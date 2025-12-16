# Cloud Autopilot VPC — Terraform IaC

This project provisions a production-ready AWS VPC using Terraform, following AWS networking best practices.

## Architecture Overview

- Custom VPC (10.0.0.0/16)
- Public and private subnets across AZs
- Internet Gateway for public access
- NAT Gateway for private subnet egress
- Separate public and private route tables
- Explicit subnet-to-route-table associations
- Fully managed via Terraform (IaC)

## AWS Resources

- VPC
- Subnets (Public & Private)
- Internet Gateway
- NAT Gateway + Elastic IP
- Route Tables (Public & Private)
- Route Table Associations

## Terraform Features

- Clean, modular Terraform files
- Tagged resources for clarity and cost tracking
- `terraform plan` shows **no drift**
- Infrastructure fully reconciled with state

## Screenshots

### AWS Console (Architecture)
See `cloud-autopilot-terraform-screens/01-aws-console/`

### Terraform Validation
See `cloud-autopilot-terraform-screens/02-terminal-vscode/09-terraform-plan-clean.png`

## How to Use

```bash
terraform init
terraform plan
terraform apply