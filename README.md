# Threat Composer ECS

This project automates the deployment of the **Threat Composer Application** using **AWS ECS**, **Terraform**, **Docker**, and **CI/CD pipelines**. Originally set up manually using **AWS Console**, the process has been automated to provide a secure, scalable, and streamlined deployment.

<br>

## Overview

The **Threat Composer Application** is a containerised React TypeScript application deployed on **AWS ECS Fargate**. This comprehensive threat modelling tool enables security professionals and architects to systematically identify, document, and mitigate threats to their systems. The deployment process is fully automated using **CI/CD pipelines** to handle Docker image building, security scans, and deployment to AWS through **Terraform**.

<br>

## Architecture Diagram

The architecture comprises the following AWS services working together to provide a highly available, scalable threat modelling platform:

- **ECS Fargate** for serverless container orchestration
- **Application Load Balancer (ALB)** for routing HTTPS traffic
- **Route 53** for custom domain name management and DNS
- **Security Groups** for network access control
- **VPC with public and private subnets** for network isolation
- **ECR (Elastic Container Registry)** for container image storage

<br>

## Key Components:

- **Dockerisation**: The application is containerised using a **multi-stage Dockerfile** for optimised production builds and reduced image size.

- **Infrastructure as Code (IaC)**: Terraform provisions the following AWS resources:
    - **ECS Fargate** for serverless container orchestration without server management.
    - **Application Load Balancer (ALB)** for routing HTTPS/HTTP traffic to the containerised application.
    - **Route 53** for custom domain name mapping and DNS management.
    - **Security Groups** to control inbound and outbound network access.
    - **VPC, Public Subnets, and Private Subnets** to establish secure network architecture with proper isolation.
    - **Internet Gateway** to enable internet connectivity for the public subnets.

- **CI/CD Pipeline**: GitHub Actions automate:
    - **Building and pushing the Docker image** to **Amazon ECR** for secure image storage.
    - **Planning Terraform configuration** to preview AWS infrastructure changes.
    - **Applying Terraform** to deploy or update AWS infrastructure in production.
    - **Performing security scans** with **Trivy** to ensure container image security.
    - **Destroying Terraform resources** when necessary for cost optimisation.
    - **Testing OIDC authentication** to ensure secure GitHub Actions-to-AWS credential exchange.

<br>

## Directory Structure

```
./
├── app
│   └── Dockerfile
├── terraform
│   ├── bootstrap
│   │   ├── main.tf
│   │   └── provider.tf
│   └── deployment
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── modules
│           ├── vpc
│           ├── alb
│           ├── ecs
│           └── route53
└── .github
    └── workflows
        ├── dockerimage-ecr.yml
        ├── terraformplan-pipeline.yml
        ├── terraformapply-pipeline.yml
        ├── terraformdestroy-pipeline.yml
        └── test-oidc-authentication.yml
```

- **Docker File** (`app/`):
    - **Dockerfile**: Multi-stage build that compiles the React TypeScript application and serves the optimised production build.

- **Terraform Files** (`terraform/`):
    - **bootstrap/**: Sets up OIDC provider and IAM roles for GitHub Actions (run once before main deployment).
    - **deployment/modules/vpc**: Provisions VPC, subnets, and internet gateway.
    - **deployment/modules/alb**: Configures Application Load Balancer with target groups.
    - **deployment/modules/ecs**: Creates ECS cluster, task definitions, and Fargate services.
    - **deployment/modules/route53**: Manages Route 53 DNS records and SSL certificates.

- **CI/CD Pipelines** (`.github/workflows/`):
    - **dockerimage-ecr.yml**: Builds and pushes Docker image to Amazon ECR.
    - **terraformplan-pipeline.yml**: Previews Terraform configuration changes.
    - **terraformapply-pipeline.yml**: Applies Terraform to provision AWS resources.
    - **terraformdestroy-pipeline.yml**: Destroys Terraform-managed infrastructure.
    - **test-oidc-authentication.yml**: Verifies OIDC authentication configuration.

<br>



## Prerequisites

### 1. AWS Account Setup

Before deploying, ensure the following AWS prerequisites are met:

- **AWS Account**: An active AWS account with appropriate permissions
- **AWS CLI**: Installed and configured with credentials
- **Terraform**: Version 1.0 or later installed locally
- **Docker**: Installed for building and testing Docker images locally

### 2. GitHub Configuration

For automated CI/CD deployment:

- **GitHub Repository**: Repository with this project code
- **GitHub Secrets**: Configure the following secrets:
    - `AWS_ROLE_ARN`: IAM role for GitHub Actions (created during bootstrap)
    - `AWS_REGION`: AWS region (e.g., `eu-west-2`)

### 3. Terraform State Management

- **S3 Bucket**: Created for storing Terraform state files (optional but recommended)
- **State Locking**: Consider using DynamoDB for state locking in shared environments

### 4. Domain Configuration

- **Custom Domain**: (Optional) Register a custom domain in Route 53 for accessing the application
- **SSL Certificate**: Route 53 automatically manages SSL certificates with HTTPS validation

<br>

## CI/CD Deployment Workflow

The deployment process is fully automated via GitHub Actions:

1. **Docker Image Build & Deployment** (`dockerimage-ecr.yml`):
    - Builds the Docker image using the multi-stage Dockerfile
    - Runs **Trivy** to scan for vulnerabilities before pushing to ECR
    - Pushes the image to **Amazon ECR**

2. **Terraform Plan** (`terraformplan-pipeline.yml`):
    - Initialises the Terraform directory
    - Previews the necessary AWS resources (VPC, ALB, ECS, Route 53)

3. **Terraform Apply** (`terraformapply-pipeline.yml`):
    - Initialises the Terraform directory
    - Provisions the necessary AWS resources

4. **Terraform Destroy** (`terraformdestroy-pipeline.yml`):
    - Destroys all Terraform-managed resources when necessary

5. **OIDC Authentication Test** (`test-oidc-authentication.yml`):
    - Verifies GitHub Actions-to-AWS OIDC authentication

To trigger any of these workflows, go to **GitHub Actions** and manually run the desired workflow.

<br>

## Deployment Steps

### Step 1: Bootstrap the AWS Environment

```bash
cd terraform/bootstrap
terraform init
terraform apply
```

Note the outputs, particularly the GitHub Actions IAM role ARN.

### Step 2: Configure GitHub Actions Variables

In your GitHub repository settings:
1. Go to **Settings** → **Secrets and variables** → **Actions** → **Variables**
2. Create the following variables:
   - `AWS_ROLE_ARN`: From bootstrap output
   - `AWS_REGION`: Your AWS region (e.g., `eu-west-2`)

### Step 3: Deploy Infrastructure

1. Navigate to **GitHub Actions** in your repository
2. Click **Running a Terraform Plan**
3. Click **Run workflow**
4. Once review is complete, click **Terraform Apply**
5. Click **Run workflow**

This will:
- Create the VPC with public and private subnets
- Set up the Application Load Balancer
- Provision the ECS Fargate cluster and service
- Configure Route 53 DNS records
- Manage SSL/TLS certificates

### Step 4: Update Application Code (Optional)

When ready to deploy application updates:
1. Make changes to files in the `app/` directory
2. Commit and push to the `main` branch
3. The Docker build pipeline automatically triggers
4. Trivy scans the image for vulnerabilities
5. Image is pushed to ECR
6. ECS service is updated with the new image (manual or via auto-rollout)

### Step 5: Access the Application

Once deployed:
- **Via ALB DNS**: Access through the Application Load Balancer DNS name (shown in Terraform output)
- **Via Custom Domain**: If configured, access through your Route 53 custom domain with HTTPS
- **Health Check**: Application exposes health check endpoint at `/health`

<br>














