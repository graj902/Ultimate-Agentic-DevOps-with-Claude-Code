# DMI Portfolio Website

A static HTML/CSS portfolio website deployed on AWS using S3, CloudFront, Terraform, and GitHub Actions.

## Architecture

| Component | Technology |
|-----------|------------|
| Site | Static HTML5 + CSS3 (no build step) |
| Storage | AWS S3 (private bucket, no public access) |
| CDN | Amazon CloudFront with Origin Access Control (OAC) |
| IaC | Terraform |
| CI/CD | GitHub Actions with OIDC authentication |
| State | S3 backend with DynamoDB locking |

## Project Structure

```
.
├── index.html              # Main portfolio page
├── style.css               # Styles
├── privacy.html            # Privacy policy
├── terms.html              # Terms of service
├── images/                 # Static assets
├── terraform/              # Infrastructure as Code
│   ├── providers.tf
│   ├── variables.tf
│   ├── backend.tf
│   ├── main.tf
│   └── outputs.tf
└── .github/workflows/
    └── deploy.yml          # CI/CD pipeline
```

## Prerequisites

- AWS CLI configured with credentials
- Terraform >= 1.5
- AWS account with permissions to create S3, CloudFront, IAM, DynamoDB

## Setup

### 1. Bootstrap Terraform State Backend

The S3 backend bucket and DynamoDB lock table must exist before using remote state.

```bash
cd terraform

# Step 1: Initialize with local state (backend is commented out)
terraform init

# Step 2: Create state bucket and lock table
terraform plan
terraform apply

# Step 3: Uncomment backend block in backend.tf
# Step 4: Migrate state to S3
terraform init
```

### 2. Deploy Infrastructure

```bash
cd terraform
terraform plan
terraform apply
```

After apply, note the outputs:
- `s3_bucket_name` — for GitHub Secret `S3_BUCKET_NAME`
- `cloudfront_distribution_id` — for GitHub Secret `CLOUDFRONT_DISTRIBUTION_ID`
- `iam_role_arn` — for GitHub Secret/Variable `AWS_ROLE_ARN`

### 3. Configure GitHub Secrets/Variables

Go to **Settings → Secrets and variables → Actions** and add:

| Type | Name | Value |
|------|------|-------|
| Secret | `AWS_ROLE_ARN` | Terraform output `iam_role_arn` |
| Secret | `S3_BUCKET_NAME` | Terraform output `s3_bucket_name` |
| Secret | `CLOUDFRONT_DISTRIBUTION_ID` | Terraform output `cloudfront_distribution_id` |
| Variable | `AWS_REGION` | `eu-north-1` |

### 4. Deploy Site

Push to `main` — GitHub Actions will sync files to S3 and invalidate CloudFront automatically.

## Infrastructure Details

### Security

- S3 bucket is **private** with all public access blocked
- CloudFront uses **Origin Access Control** (OAC) — no legacy OAI
- GitHub Actions authenticates via **OIDC** — no long-lived AWS keys
- IAM role is **repo-scoped** with least privilege (S3 sync + CloudFront invalidation only)
- All S3 buckets have **server-side encryption (SSE-S3)** and **versioning** enabled

### Terraform State

- Stored in S3 with **AES256 encryption**
- Locked via **DynamoDB** to prevent concurrent modifications

## CI/CD Pipeline

On push to `main` (when site files change):

1. Checkout repository
2. Configure AWS credentials via OIDC
3. Sync site files to S3 (`aws s3 sync --delete`)
4. Invalidate CloudFront cache (`aws cloudfront create-invalidation --paths "/*"`)

## Local Development

Open `index.html` directly in a browser — no build step required.

---

## History / DMI Context

This repository originated as a **DevOps Micro Internship (DMI)** Week 1 exercise where students deployed a static site on Ubuntu with Nginx and kept it live for 24 hours. The project has since evolved to use modern cloud-native practices with AWS S3, CloudFront, Terraform, and GitHub Actions.