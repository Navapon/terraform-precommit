resource "aws_s3_bucket" "this" {
  force_destroy = var.force_destroy
  bucket        = var.bucket
  tags          = var.tags

  object_lock_enabled = var.bucket_lock_enabled
}

resource "aws_s3_bucket_policy" "this" {
  count = var.bucket_policy != null ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]
  count      = var.object_ownership == "BucketOwnerEnforced" ? 0 : 1

  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning_configuration_status
  }
}

resource "aws_s3_bucket_object_lock_configuration" "this" {
  depends_on = [aws_s3_bucket_versioning.this]
  count      = var.object_lock_configuration.object_lock_enabled ? 1 : 0
  bucket     = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = try(flatten([var.object_lock_configuration["rule"]]), [])

    content {
      default_retention {
        mode = rule.value.default_retention.mode
        days = rule.value.default_retention.days
      }
    }
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket                = aws_s3_bucket.this.id
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "rule" {
    for_each = try(flatten([var.server_side_encryption_configuration["rule"]]), [])

    content {
      bucket_key_enabled = try(rule.value.bucket_key_enabled, null)

      dynamic "apply_server_side_encryption_by_default" {
        for_each = try([rule.value.apply_server_side_encryption_by_default], [])

        content {
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
          kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
        }
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  ignore_public_acls      = var.ignore_public_acls
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.create_s3_website_configuration ? 1 : 0
  bucket = aws_s3_bucket.this.bucket

  routing_rules = var.routing_rules

  index_document {
    suffix = var.website.index_document.suffix
  }

  error_document {
    key = var.website.error_document.key
  }
}

resource "aws_s3_bucket_logging" "this" {
  count  = length(var.logging) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.bucket

  target_bucket = var.logging.target_bucket
  target_prefix = var.logging.target_prefix
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  count = var.intelligent_tiering.enable ? 1 : 0

  bucket = aws_s3_bucket.this.id
  name   = var.intelligent_tiering.name

  dynamic "tiering" {
    for_each = var.intelligent_tiering.tiering

    content {
      access_tier = tiering.value.access_tier
      days        = tiering.value.days
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.s3lifecycle

    content {
      abort_incomplete_multipart_upload {
        days_after_initiation = 7
      }

      id     = rule.value.id
      status = rule.value.status

      dynamic "filter" {
        for_each = rule.value.filter != null ? [1] : []
        content {
          prefix = rule.value.filter != null ? rule.value.filter.prefix : null
        }
      }

      dynamic "expiration" {

        for_each = rule.value.expiration != null ? [1] : []
        content {
          days = rule.value.expiration
        }
      }

      dynamic "transition" {
        for_each = rule.value.transition
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = rule.value.noncurrent_version_expiration != null ? [rule.value.noncurrent_version_expiration] : []
        content {
          newer_noncurrent_versions = noncurrent_version_expiration.value.newer_noncurrent_versions
          noncurrent_days           = noncurrent_version_expiration.value.noncurrent_days
        }
      }
    }
  }
}
