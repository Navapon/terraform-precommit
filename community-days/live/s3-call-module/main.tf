resource "aws_kms_key" "s3_key" {
  description         = "This key is used to encrypt S3 bucket objects"
  enable_key_rotation = true
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  bucket                  = "aws_community_day_bucket"
  acl                     = "private"
  force_destroy           = true
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_policy     = true
  block_public_acls       = true

  # versioning = {
  #   enabled = true
  # }

  # server_side_encryption_configuration = {
  #   rule = {
  #     apply_server_side_encryption_by_default = {
  #       sse_algorithm     = "aws:kms"
  #       kms_master_key_id = aws_kms_key.s3_key.arn
  #     }
  #   }
  # }
}
