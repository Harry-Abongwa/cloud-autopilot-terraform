# Cloud Autopilot – Production-Grade AWS Networking with Terraform

## Overview
Cloud Autopilot is a production-ready AWS networking foundation built using Terraform.  
It demonstrates how to **adopt existing AWS infrastructure into Terraform**, resolve real-world state conflicts, and manage a scalable, secure VPC architecture.

This project reflects **enterprise infrastructure practices**, not tutorials.

---

## Architecture
**Region:** us-east-2 (Ohio)

**VPC Design**
- Custom VPC: `10.0.0.0/16`
- DNS support & hostnames enabled

**Subnets**
- Public Subnet A (us-east-2a) – `10.0.1.0/24`
- Public Subnet B (us-east-2b) – `10.0.3.0/24`
- Private Subnet A (us-east-2a) – `10.0.2.0/24`

**Routing**
- Internet Gateway for public subnets
- NAT Gateway for private subnet egress
- Separate public and private route tables

**Compute**
- Auto Scaling Group (1–2 instances)
- EC2 managed exclusively via AWS Systems Manager (no SSH)

---

## Key Skills Demonstrated
- Terraform state imports (VPC, subnets, IGW, NAT, route tables)
- Resolving route table association conflicts
- Managing AWS defaults without destructive changes
- Production-safe Terraform workflows
- Cost-aware scaling and infrastructure control

---

## Why This Matters
Most Terraform examples start from scratch.

This project shows how to:
- Take **existing AWS infrastructure**
- Bring it under Terraform management
- Fix real-world drift and conflicts
- End with a clean, controlled state

This mirrors what engineers do in **live environments**.

---

## How to Use
```bash
terraform init
terraform plan
terraform apply