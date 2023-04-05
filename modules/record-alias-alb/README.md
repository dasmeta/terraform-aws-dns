# record-alias-alb

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
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb"></a> [alb](#input\_alb) | ALB Name | `string` | n/a | yes |
| <a name="input_geolocation_routing_policy"></a> [geolocation\_routing\_policy](#input\_geolocation\_routing\_policy) | Routing policy, for now only geolocation supported | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | DNS Record Name | `string` | n/a | yes |
| <a name="input_set_identifier"></a> [set\_identifier](#input\_set\_identifier) | Routing policy unique identifier | `any` | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | DNS Zone Id | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
