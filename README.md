# terraform-aws-dns
Allows to create aws route53 zone and record with simple manner,
supports alb/loadbalancer and cdn/cloudfront cases

# for enabling git pre-commit/commit-msg hooks run this(other repos will also have it set as it set globally)
```sh
git config --global core.hooksPath ./githooks
```

# simple example with alb
```hcl
module "dns" {
  source  = "dasmeta/dns/aws"
  version = "1.0.1"

  zone        = "test.dasmeta.com"
  records     = [
    {
      target_type = "alb"
      name        = "app1"
      alb         = "k8s-my-test-alb"
    }
  ]
}
```
## Standard records and per-record TTL

Standard records can share a name when their DNS types differ. For example,
configure A and TXT for `example.com` in the same `records` list:

```hcl
records = [
  {
    name  = "example.com"
    type  = "A"
    value = ["192.0.2.10"]
  },
  {
    name  = "example.com"
    type  = "TXT"
    value = ["verification=example"]
    ttl   = 300
  },
]
```

The A record uses the default TTL of 30 seconds; the TXT record uses 300 seconds.
`ttl` is optional and accepts a number of seconds. Omitted or null TTL uses 30.
Changing one record's TTL does not affect other records. Multiple values of the
same name and type belong in a single record's `value` list; duplicate name/type
definitions remain invalid. TTL configuration applies to standard records;
ALB and CloudFront aliases continue to use their target's TTL behavior.

See [the complete example](tests/record-types-ttl/).

## Upgrading existing standard records

Standard-record Terraform instance keys now include the type: `example.com-A`
instead of `example.com`. This affects every existing standard record, including
records whose names were already unique. DNS names, record types, and zone/alias
resource addresses do not change.

Before applying an upgrade, migrate each existing standard record's state
address. A consumer configuration using `module "dns"` can add a `moved` block
for each existing record, using its actual previous name and type:

```hcl
moved {
  from = module.dns.module.zone_and_records.aws_route53_record.add_record["example.com"]
  to   = module.dns.module.zone_and_records.aws_route53_record.add_record["example.com-A"]
}
```

Alternatively, back up the selected workspace's state and run the equivalent
state move in the consumer configuration directory:

```sh
terraform state mv \
  'module.dns.module.zone_and_records.aws_route53_record.add_record["example.com"]' \
  'module.dns.module.zone_and_records.aws_route53_record.add_record["example.com-A"]'
```

Adjust the full module path and repeat for each existing standard record. Direct
Route53 submodule consumers omit the `.module.zone_and_records` path segment.
Review `terraform plan` before applying: migrated records must not be destroyed
or recreated solely because of their new keys. Newly added records may show
creation, and intended TTL changes may show updates. Without state migration,
Terraform will plan deletion of old instances and creation at the new addresses.
No universal module-level move can cover arbitrary consumer record names/types.
See [Terraform module refactoring](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring).

## Local regression tests

The module retains its Terraform `~> 1.3` consumer requirement. Mock-provider
tests require Terraform >= 1.7 and jq; no AWS credentials are required.

```sh
terraform init -backend=false
bash tests/check-records.sh
```

The runner checks actual planned root record values and native Route53 assertions,
then verifies that the separate negative fixture rejects duplicate name/type pairs.
Every test uses a mock AWS provider and `command = plan`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.31 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_records"></a> [alb\_records](#module\_alb\_records) | ./modules/record-alias-alb | n/a |
| <a name="module_cdn_records"></a> [cdn\_records](#module\_cdn\_records) | ./modules/record-alias-cdn | n/a |
| <a name="module_zone_and_records"></a> [zone\_and\_records](#module\_zone\_and\_records) | ./modules/route53 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_zone"></a> [create\_zone](#input\_create\_zone) | Create zone or use existing zone as data | `bool` | `false` | no |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | If Route53 zone is private set var is true | `bool` | `false` | no |
| <a name="input_records"></a> [records](#input\_records) | DNS Record map | <pre>list(object({<br/>    name        = string<br/>    target_type = optional(string, "") # for cdn/alb record easy creation can be "alb", "cdn"<br/><br/>    type  = optional(string, "A")   # type for standard records creation, can be "A", "CNAME", "TEXT", and etc<br/>    value = optional(list(any), []) # value for standard records creation<br/>    ttl   = optional(number, 30)    # TTL in seconds for standard records<br/><br/>    alb = optional(string, null) # the name of loadbalancer<br/><br/>    distribution_id = optional(string, null) # cloudfront distribution id<br/><br/>    set_identifier : optional(string, null)        # for setting custom identifier in case we have multiple records(geo routing) for same domain<br/>    geolocation_routing_policy : optional(any, {}) # use to define custom routing for each geo location<br/>  }))</pre> | `[]` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | List of VPC IDs to associate with the Route53 Zone, being used if only private\_zone and create\_zone are true | `list(string)` | `[]` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | DNS Zone name record will be injected into | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ns_delegation_set"></a> [ns\_delegation\_set](#output\_ns\_delegation\_set) | The NS records list for zone to use as delegation set |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | zone id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
