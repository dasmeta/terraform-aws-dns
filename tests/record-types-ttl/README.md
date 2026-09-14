# Same-name record types and individual TTL

This example configures an example.com hosted zone with an A record (default TTL
30 seconds) and a TXT record (explicit TTL 300 seconds) at the same name.
`example.com` and `192.0.2.10` are documentation placeholders.

For a real deployment, use a domain you control and configure AWS credentials.
To use an existing zone, set `create_zone = false`.

```sh
terraform init
terraform plan
```

For local verification without AWS credentials or resource creation, run from
the repository root using Terraform >= 1.7 and jq:

```sh
terraform init -backend=false
bash tests/check-records.sh
```

The regression suite mocks AWS and runs plans only. See the root README for
existing-record state migration instructions before upgrading a live configuration.
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
| <a name="module_this"></a> [this](#module\_this) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
