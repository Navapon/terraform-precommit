# Command

## install

```bash
brew install infracost
infracost auth login
```

## Run Command Infracost

```bash
infracost breakdown --path=. 
```

## Run with Pre-commit

```bash
/Users/navapon/Personal/terraform-precommit/community-days/live/infracost
pre-commit run infracost_breakdown --file main.tf  
```

<!-- BEGIN_TF_DOCS -->
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
| [aws_instance.community_demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.al2023_arm64](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t4g.nano"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->