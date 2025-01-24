output "bucket_id" {
  value       = aws_s3_bucket.this.id
  description = "output of bucket id"
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "output of bucket arn"
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.this.bucket_regional_domain_name
  description = "output of bucket domain name"
}

output "website_endpoint" {
  value       = aws_s3_bucket_website_configuration.this[*].website_endpoint != null ? one(aws_s3_bucket_website_configuration.this[*].website_endpoint) : "S3 static website is not configured"
  description = "output of s3 static website endpoint"
}
