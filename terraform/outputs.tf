output "s3_bucket_name" {
  description = "Name of the static site S3 bucket"
  value       = aws_s3_bucket.site.id
}

output "s3_bucket_arn" {
  description = "ARN of the static site S3 bucket"
  value       = aws_s3_bucket.site.arn
}

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution (e.g., d123456.cloudfront.net)"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.site.arn
}

output "iam_role_arn" {
  description = "ARN of the GitHub Actions IAM role"
  value       = aws_iam_role.github_actions.arn
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub OIDC identity provider (import existing if already present in AWS account)"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "terraform_state_bucket_name" {
  description = "Name of the Terraform state S3 bucket"
  value       = aws_s3_bucket.terraform_state.id
}

output "terraform_locks_table_name" {
  description = "Name of the Terraform state lock DynamoDB table"
  value       = aws_dynamodb_table.terraform_locks.name
}