# terraform-aws-dns
Allows to create aws route53 zone and record with simple manner,
supports alb/loadbalancer and cdn/cloudfront cases

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
| <a name="input_records"></a> [records](#input\_records) | DNS Record map | <pre>list(object({<br>    name        = string<br>    target_type = optional(string, "") # for cdn/alb record easy creation can be "alb", "cdn"<br><br>    type  = optional(string, "A")   # type for standard records creation, can be "A", "CNAME", "TEXT", and etc<br>    value = optional(list(any), []) # value for standard records creation<br><br>    alb = optional(string, null) # the name of loadbalancer<br><br>    distribution_id = optional(string, null) # cloudfront distribution id<br><br>    set_identifier : optional(string, null)        # for setting custom identifier in case we have multiple records(geo routing) for same domain<br>    geolocation_routing_policy : optional(any, {}) # use to define custom routing for each geo location<br>  }))</pre> | `[]` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | DNS Zone name record will be injected into | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | zone id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
