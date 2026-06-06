variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "dmi-portfolio"
}

variable "environment" {
  description = "Environment name (e.g., production, staging)"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-north-1"
}

variable "domain_name" {
  description = "Optional custom domain name for CloudFront aliases (e.g., example.com)"
  type        = string
  default     = ""
}

variable "github_repo" {
  description = "GitHub repository for OIDC IAM role trust policy (format: owner/repo)"
  type        = string
  default     = "pravinmishraaws/Ultimate-Agentic-DevOps-with-Claude-Code"
}