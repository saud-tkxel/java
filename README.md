# Java Web Application Deployment to AWS EKS

## Prerequisites

- AWS account with appropriate permissions
- Docker installed
- ECR Private Repo configured for the Application image 
- AWS CLI installed and configured
- Terraform installed
- Helm installed

## Steps to Deploy

1. Clone the repository.
2. Set up AWS credentials.
3. Run Terraform commands to provision the infrastructure.
4. Build and push Docker image using GitHub Actions.
5. Deploy to EKS using Helm.

## AWS Credentials Setup

1. Store AWS credentials in GitHub secrets.
2. Used the `aws-actions/configure-aws-credentials` action to configure AWS credentials in GitHub Actions.
