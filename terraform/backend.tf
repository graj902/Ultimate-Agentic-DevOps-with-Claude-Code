# ============================================================
# BOOTSTRAP NOTE — READ BEFORE RUNNING terraform init
# ============================================================
# The S3 backend bucket and DynamoDB lock table do not exist yet.
# They will be created by main.tf resources in Chunk 2.
#
# Bootstrap process:
#   1. Comment out the terraform {} block below (this file).
#   2. Run: terraform init
#      → Terraform will use local state (.terraform/terraform.tfstate).
#   3. Run: terraform plan && terraform apply
#      → Creates the S3 state bucket and DynamoDB lock table.
#   4. Uncomment the terraform {} block (restore this file).
#   5. Run: terraform init
#      → Terraform will prompt to migrate state to S3.
#      → Confirm: type "yes"
#   6. Done — state is now in S3 with DynamoDB locking.
#
# Note: Backend configuration cannot use variables. If you changed the defaults
# in variables.tf, update these literal strings to match.
# ============================================================

# terraform {
#   backend "s3" {
#     bucket         = "dmi-portfolio-terraform-state-production"
#     key            = "terraform.tfstate"
#     region         = "eu-north-1"
#     dynamodb_table = "dmi-portfolio-terraform-locks-production"
#     encrypt        = true
#   }
# }