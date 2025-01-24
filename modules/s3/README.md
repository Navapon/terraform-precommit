# s3

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.80 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.84.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_object_lock_configuration.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | (Optional, One of acl or access\_control\_policy is required) Canned ACL to apply to the bucket. | `string` | `"private"` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: | `bool` | `true` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Naming of this bucket | `string` | `"no-name"` | no |
| <a name="input_bucket_lock_enabled"></a> [bucket\_lock\_enabled](#input\_bucket\_lock\_enabled) | This value for enable object lock at bucket but no need to default retention | `bool` | `false` | no |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | Resource base policy of bucket | `string` | n/a | yes |
| <a name="input_create_s3_website_configuration"></a> [create\_s3\_website\_configuration](#input\_create\_s3\_website\_configuration) | S3 Webhost configuration Enabled | `bool` | n/a | yes |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | Account ID of the expected bucket owner. | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error. https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket#force_destroy | `bool` | `false` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true | `bool` | `true` | no |
| <a name="input_intelligent_tiering"></a> [intelligent\_tiering](#input\_intelligent\_tiering) | Configuration of intelligent tiering | <pre>object({<br/>    enable = bool<br/>    name   = optional(string)<br/>    tiering = optional(list(object({<br/>      access_tier = string<br/>      days        = number<br/>    })))<br/>  })</pre> | <pre>{<br/>  "enable": false<br/>}</pre> | no |
| <a name="input_logging"></a> [logging](#input\_logging) | S3 logging centerization | `map(any)` | `{}` | no |
| <a name="input_object_lock_configuration"></a> [object\_lock\_configuration](#input\_object\_lock\_configuration) | This value for enable object lock with retention | <pre>object({<br/>    object_lock_enabled = bool<br/>    rule = object({<br/>      default_retention = object({<br/>        mode = string<br/>        days = number<br/>      })<br/>    })<br/>  })</pre> | <pre>{<br/>  "object_lock_enabled": false,<br/>  "rule": {<br/>    "default_retention": {<br/>      "days": 7,<br/>      "mode": "GOVERNANCE"<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | disable ACLs disabled (recommended) from aws security best practice | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: | `bool` | `true` | no |
| <a name="input_routing_rules"></a> [routing\_rules](#input\_routing\_rules) | Routing Rule of S3 | `string` | `null` | no |
| <a name="input_s3lifecycle"></a> [s3lifecycle](#input\_s3lifecycle) | Configuration of s3 life cycle | <pre>list(object({<br/>    id     = string<br/>    status = string<br/>    filter = optional(object({<br/>      prefix = optional(string)<br/>      tags   = optional(map(string))<br/>    }))<br/>    transition = list(object({<br/>      days          = number<br/>      storage_class = string<br/>    }))<br/>    expiration = optional(number)<br/>    noncurrent_version_expiration = optional(object({<br/>      newer_noncurrent_versions = number<br/>      noncurrent_days           = number<br/>    }))<br/>  }))</pre> | <pre>[<br/>  {<br/>    "expiration": null,<br/>    "id": "Default INTELLIGENT_TIERING Lifecycle",<br/>    "noncurrent_version_expiration": {<br/>      "newer_noncurrent_versions": 3,<br/>      "noncurrent_days": 30<br/>    },<br/>    "status": "Enabled",<br/>    "transition": [<br/>      {<br/>        "days": 7,<br/>        "storage_class": "INTELLIGENT_TIERING"<br/>      }<br/>    ]<br/>  }<br/>]</pre> | no |
| <a name="input_server_side_encryption_configuration"></a> [server\_side\_encryption\_configuration](#input\_server\_side\_encryption\_configuration) | Specific Service side encryption https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket_server_side_encryption_configuration#apply_server_side_encryption_by_default | <pre>object({<br/>    rule = list(object({<br/>      bucket_key_enabled = bool<br/>      apply_server_side_encryption_by_default = object({<br/>        kms_master_key_id = optional(string)<br/>        sse_algorithm     = optional(string)<br/>      })<br/>    }))<br/>  })</pre> | <pre>{<br/>  "rule": [<br/>    {<br/>      "apply_server_side_encryption_by_default": {<br/>        "sse_algorithm": "AES256"<br/>      },<br/>      "bucket_key_enabled": true<br/>    }<br/>  ]<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags of bucket | `map(string)` | n/a | yes |
| <a name="input_versioning_configuration_status"></a> [versioning\_configuration\_status](#input\_versioning\_configuration\_status) | Bucket Versioning Status | `string` | `"Enabled"` | no |
| <a name="input_website"></a> [website](#input\_website) | S3 Webhost configuration | <pre>object({<br/>    index_document = object({<br/>      suffix = string<br/>    })<br/>    error_document = object({<br/>      key = string<br/>    })<br/>  })</pre> | <pre>{<br/>  "error_document": {<br/>    "key": "index.html"<br/>  },<br/>  "index_document": {<br/>    "suffix": "index.html"<br/>  }<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | output of bucket arn |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | output of bucket id |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | output of bucket domain name |
| <a name="output_website_endpoint"></a> [website\_endpoint](#output\_website\_endpoint) | output of s3 static website endpoint |
<!-- END_TF_DOCS -->
