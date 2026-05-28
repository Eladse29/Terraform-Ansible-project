# AWS DevOps Automation Project

## Project Overview

This project demonstrates a complete automated AWS infrastructure and application deployment workflow using:

- Terraform for Infrastructure as Code (IaC)
- Ansible for Configuration Management and Application Deployment
- AWS services including EC2, RDS, S3, SNS, VPC and Security Groups

The system consists of three application services:

1. Frontend Server (nginx)
2. Backend API Service (Flask)
3. Worker Service (Flask)

The infrastructure can be recreated from scratch automatically using Terraform and configured automatically using Ansible.

---

# Architecture Diagram

A separate architecture diagram file is attached with the project submission.

The diagram includes:

- VPC and Subnets
- EC2 Instances
- Security Groups
- RDS PostgreSQL
- S3 Bucket
- SNS Topic
- nginx Reverse Proxy
- Communication flows between services
- Terraform vs Ansible responsibilities

---

# Technologies Used

## Infrastructure

- Terraform
- AWS EC2
- AWS VPC
- AWS Security Groups
- AWS RDS PostgreSQL
- AWS S3
- AWS SNS

## Configuration Management

- Ansible
- systemd
- nginx

## Application Stack

- Python Flask
- PostgreSQL
- boto3
- requests

---

# Infrastructure Created by Terraform

Terraform automatically creates:

- VPC
- Public and Private Subnets
- Route Tables
- Internet Gateway
- Security Groups
- 3 EC2 Instances
- PostgreSQL RDS Instance
- S3 Bucket
- SNS Topic and Email Subscription
- IAM permissions required by the backend application

---

# Configuration Performed by Ansible

Ansible automatically performs:

- Package installation
- nginx installation and configuration
- Flask dependencies installation
- Application deployment
- Environment variables configuration
- systemd service creation
- Reverse proxy configuration
- Service restart and enable on boot

---

# EC2 Servers

| Server | Purpose | Access |
|---|---|---|
| Frontend | nginx reverse proxy + UI | Public HTTP |
| Backend | Flask API | Internal only |
| Worker | Background worker service | Internal only |

---

# Security Design

Security Groups were configured using least privilege principles:

- Frontend allows:
  - HTTP (80) from anywhere
  - SSH (22) only from the developer IP

- Backend allows:
  - Port 5000 only from Frontend Security Group
  - SSH only from the developer IP

- Worker allows:
  - Port 5001 only from Backend Security Group
  - SSH only from the developer IP

- RDS allows:
  - PostgreSQL 5432 only from Backend Security Group

---

# Terraform Project Structure

```text
terraform/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── modules/
    ├── networking/
    ├── security_groups/
    ├── ec2/
    ├── rds_postgresql/
    ├── s3/
    ├── sns/
    └── iam/
```

---

# Ansible Project Structure

```text
ansible/
├── inventory.ini
├── generate_inventory.sh
├── playbook.yml
├── secrets.yml
└── roles/
    ├── common/
    ├── frontend/
    ├── backend/
    └── worker/
```

---

# Terraform Variables

Examples of Terraform variables:

- AWS region
- instance type
- AMI ID
- project name
- environment name
- bucket name
- database credentials
- developer IP address

---

# Terraform Outputs

Terraform outputs include:

- Frontend public IP
- Backend public IP
- Worker public IP
- Backend private IP
- Worker private IP
- RDS endpoint
- S3 bucket name
- SNS topic ARN

---

# Dynamic Inventory Bonus

Since EC2 public and private IP addresses change after Terraform destroy/apply cycles, the Ansible inventory file is generated automatically from Terraform outputs.

After Terraform creates the infrastructure:

```bash
cd ansible
./generate_inventory.sh
```

The script automatically updates:

- Frontend public IP
- Backend public IP
- Worker public IP
- Backend private IP
- Worker private IP
- RDS endpoint
- S3 bucket name
- SNS topic ARN

This prevents manual inventory updates after every infrastructure recreation.

---

# Terraform State Management

Terraform state is managed locally.

The state file is stored inside the Terraform directory:

```text
terraform.tfstate
```

The state file is not uploaded to GitHub and is excluded using `.gitignore`.

---

# Secrets Management

Sensitive values are not committed to Git.

The following files are excluded from GitHub:

```text
terraform.tfvars
ansible/secrets.yml
*.tfstate
*.tfstate.*
.pem
```

Application secrets are injected through:

- Terraform variables
- Ansible environment templates
- secrets.yml

---

# How to Run Terraform

## Initialize Terraform

```bash
terraform init
```

## Preview Infrastructure

```bash
terraform plan
```

## Create Infrastructure

```bash
terraform apply
```

## View Outputs

```bash
terraform output
```

## Destroy Infrastructure

```bash
terraform destroy
```

---

# How to Run Ansible

After Terraform creates the infrastructure:

```bash
cd ansible
./generate_inventory.sh
```

Then run:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

---

# Application Features

## Frontend Dashboard

- Create virtual machines
- Validate CPU and RAM combinations
- View provisioned machines
- Trigger Worker service
- Upload reports to S3
- Send SNS notifications

## Backend API

Endpoints:

```text
/api/health
/api/machines
/api/provision
/api/worker
/api/upload
```

## Worker Service

Handles internal processing requests from the backend.

---

# Verification Steps

## Terraform

```bash
terraform plan
terraform apply
terraform output
```

## Ansible

```bash
cd ansible
./generate_inventory.sh
ansible-playbook -i inventory.ini playbook.yml
```

## Application

Open:

```text
http://FRONTEND_PUBLIC_IP
```

Verify:

- UI loads successfully
- Machines can be created
- Records are stored in PostgreSQL
- Worker communication works
- Upload to S3 works
- SNS email notification is received

---

# Challenges and Solutions

## Challenge: Dynamic IP Changes

EC2 public and private IPs changed after Terraform destroy/apply.

### Solution

A dynamic inventory generation script was created using Terraform outputs.

---

## Challenge: Flask Backend Failing to Start

The backend service failed because environment variables were not loaded correctly.

### Solution

Environment variables were moved into a dedicated environment file loaded by systemd.

---

## Challenge: SSH Key Permission Errors

Ansible could not connect because the PEM file permissions were too open.

### Solution

Permissions were corrected using:

```bash
chmod 400 ~/.ssh/elad2.pem
```

---

# Future Improvements

Possible future enhancements:

- HTTPS with SSL certificates
- Dynamic Ansible inventory from Terraform outputs
- Docker containers
- AWS Load Balancer
- Auto Scaling Groups
- CloudWatch monitoring
- Ansible Vault

---

# Summary

This project demonstrates a full DevOps workflow using Terraform and Ansible to automate:

- AWS infrastructure provisioning
- Application deployment
- Service configuration
- Security configuration
- Database integration
- Object storage integration
- Notification integration

The entire environment can be recreated automatically from scratch using Infrastructure as Code and Configuration Management principles.