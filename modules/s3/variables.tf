variable "acl" {
  type        = string
  description = "(Optional, One of acl or access_control_policy is required) Canned ACL to apply to the bucket."
  default     = "private"
}

variable "bucket" {
  type        = string
  description = "Naming of this bucket"
  default     = "no-name"
}

variable "force_destroy" {
  type        = bool
  description = "should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error. https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket#force_destroy"
  default     = false
}

variable "object_ownership" {
  type        = string
  description = "disable ACLs disabled (recommended) from aws security best practice"
  default     = "BucketOwnerEnforced"
}

variable "bucket_policy" {
  type        = string
  description = "Resource base policy of bucket"

}

variable "tags" {
  type        = map(string)
  description = "tags of bucket"
}

variable "block_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior:"
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to:"
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true:"
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true"
  default     = true
}

variable "expected_bucket_owner" {
  type        = string
  description = "Account ID of the expected bucket owner."
}

variable "server_side_encryption_configuration" {
  type = object({
    rule = list(object({
      bucket_key_enabled = bool
      apply_server_side_encryption_by_default = object({
        kms_master_key_id = optional(string)
        sse_algorithm     = optional(string)
      })
    }))
  })
  description = "Specific Service side encryption https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/s3_bucket_server_side_encryption_configuration#apply_server_side_encryption_by_default"
  default = {
    rule = [
      {
        apply_server_side_encryption_by_default = {
          sse_algorithm = "AES256"
        }
        bucket_key_enabled = true
      }
    ]
  }
}

variable "versioning_configuration_status" {
  type        = string
  description = "Bucket Versioning Status"
  default     = "Enabled"
}

variable "bucket_lock_enabled" {
  type        = bool
  description = "This value for enable object lock at bucket but no need to default retention"
  default     = false
}

variable "object_lock_configuration" {
  type = object({
    object_lock_enabled = bool
    rule = object({
      default_retention = object({
        mode = string
        days = number
      })
    })
  })
  description = "This value for enable object lock with retention"
  default = {
    object_lock_enabled = false
    rule = {
      default_retention = {
        mode = "GOVERNANCE"
        days = 7
      }
    }
  }
}

variable "create_s3_website_configuration" {
  type        = bool
  description = "S3 Webhost configuration Enabled"
}

variable "website" {
  type = object({
    index_document = object({
      suffix = string
    })
    error_document = object({
      key = string
    })
  })
  description = "S3 Webhost configuration"
  default = {
    error_document = {
      key = "index.html"
    }
    index_document = {
      suffix = "index.html"
    }
  }
}

variable "routing_rules" {
  type        = string
  description = "Routing Rule of S3"
  default     = null
}

variable "logging" {
  type        = map(any)
  description = "S3 logging centerization"
  default     = {}
}

variable "intelligent_tiering" {
  type = object({
    enable = bool
    name   = optional(string)
    tiering = optional(list(object({
      access_tier = string
      days        = number
    })))
  })
  description = "Configuration of intelligent tiering"

  default = {
    enable = false
  }
}

variable "s3lifecycle" {
  type = list(object({
    id     = string
    status = string
    filter = optional(object({
      prefix = optional(string)
      tags   = optional(map(string))
    }))
    transition = list(object({
      days          = number
      storage_class = string
    }))
    expiration = optional(number)
    noncurrent_version_expiration = optional(object({
      newer_noncurrent_versions = number
      noncurrent_days           = number
    }))
  }))
  description = "Configuration of s3 life cycle"
  default = [{
    id     = "Default INTELLIGENT_TIERING Lifecycle"
    status = "Enabled"
    transition = [
      {
        days          = 7
        storage_class = "INTELLIGENT_TIERING"
      }
    ]
    expiration = null,
    noncurrent_version_expiration = {
      newer_noncurrent_versions = 3
      noncurrent_days           = 30
    }
  }]

  validation {
    condition     = alltrue(flatten([for row in var.s3lifecycle : [for trans in row.transition : contains(["GLACIER", "STANDARD_IA", "ONEZONE_IA", "INTELLIGENT_TIERING", "DEEP_ARCHIVE", "GLACIER_IR"], trans.storage_class)]]))
    error_message = "Valid value is one of the following GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR"
  }

  validation {
    condition     = alltrue(flatten([for row in var.s3lifecycle : contains(["Enabled", "Disabled"], row.status)]))
    error_message = "Valid value is one of the following Enabled and Disabled"
  }
}
