#!/usr/bin/env bash
# Requires Terraform >= 1.7 and jq. All fixtures use mocked plan-only runs.
set -euo pipefail
cd "$(dirname "$0")/.."

test_log=$(mktemp "${TMPDIR:-/tmp}/dns-record-tests.XXXXXX")
trap 'rm -f "$test_log"' EXIT

if ! terraform test -json -verbose \
  -filter=tests/records.tftest.hcl \
  -filter=tests/route53.tftest.hcl > "$test_log"; then
  jq -r 'select(.type == "diagnostic" or .type == "test_summary") | .["@message"]' "$test_log"
  exit 1
fi

# Root modules expose outputs, not nested resources. Inspect the actual plan
# instead of introducing production outputs solely for test assertions.
jq -es '
  def records($run):
    [.[] | select(.type == "test_plan" and .["@testrun"] == $run)
      | .test_plan.resource_changes[]? | select(.type == "aws_route53_record")
      | {address, name: .change.after.name, type: .change.after.type,
         values: .change.after.records, ttl: .change.after.ttl,
         alias: .change.after.alias}]
    | sort_by(.address);
  records("same_name_different_types") as $pair
  | ($pair | length) == 2
    and $pair[0].address == "module.zone_and_records.aws_route53_record.add_record[\"example.com-A\"]"
    and $pair[1].address == "module.zone_and_records.aws_route53_record.add_record[\"example.com-TXT\"]"
    and $pair[0].name == "example.com" and $pair[0].type == "A"
    and $pair[0].values == ["192.0.2.10"] and $pair[0].ttl == 30
    and $pair[1].name == "example.com" and $pair[1].type == "TXT"
    and $pair[1].values == ["verification=example"] and $pair[1].ttl == 300
    and records("individual_ttl") == [$pair[1]]
    and records("reordered_records") == $pair
    and records("change_one_ttl") == ($pair | .[0].ttl = 60)
    and records("null_ttl") == [$pair[0]]
    and records("empty_records") == []
    and (records("aliases_unchanged") | length) == 2
    and (records("aliases_unchanged") | all(.ttl == null and (.alias | length) == 1))
' "$test_log" > /dev/null || {
  echo "FAIL: root module planned records do not match the name/type/TTL contract."
  exit 1
}
jq -r 'select(.type == "test_summary") | .["@message"]' "$test_log"
echo "PASS: root record values, identities, TTL defaults/overrides, ordering, and aliases."

if terraform test -json -test-directory=tests/negative > "$test_log"; then
  echo "FAIL: duplicate name/type was accepted."
  exit 1
fi
jq -es 'any(.[]; .type == "diagnostic" and .diagnostic.summary == "Duplicate object key")' "$test_log" > /dev/null || {
  jq -r 'select(.type == "diagnostic") | .["@message"]' "$test_log"
  echo "FAIL: negative fixture failed for a reason other than duplicate keys."
  exit 1
}
echo "PASS: duplicate name/type rejected."
