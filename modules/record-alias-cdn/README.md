# record-alias-cdn

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_cloudfront_distribution.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_distribution) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_distribution_id"></a> [distribution\_id](#input\_distribution\_id) | Cloudfront Distribution Id | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | DNS Record Name | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | DNS Zone Id | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
