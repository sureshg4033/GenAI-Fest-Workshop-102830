# Terraform AWS EC2 Infrastructure

This repository contains Terraform code for creating AWS EC2 instances with enhanced modularity and state management.

## Repository Structure

```
.
├── .github/
│   └── workflows/         # GitHub Actions CI/CD workflows
├── bootstrap/             # State management bootstrap configuration
├── environments/
│   ├── dev/               # Development environment configuration
│   └── staging/           # Staging environment configuration
├── modules/
│   ├── compute/           # EC2 instance module
│   ├── networking/        # VPC, subnet, and security group module
│   └── state/             # State management module (S3 bucket and DynamoDB)
└── tests/                 # Terraform unit tests using Terratest
```

## Features

- **Modular Design**: Separate modules for compute and networking resources
- **Multiple Environments**: Configurations for development and staging environments
- **Enhanced EC2 Instance Management**:
  - Support for creating multiple instances
  - Configurable root volume settings
  - Optional data volume creation and attachment
  - Enhanced lifecycle management
  - Comprehensive tagging strategy
  - Support for user data scripts and IAM instance profiles
- **State Management**:
  - Remote state storage in S3
  - State locking with DynamoDB
  - Proper lifecycle configurations
  - Explicit dependencies between resources
- **CI/CD Pipeline**:
  - Automated Terraform validation and linting
  - Unit testing with Terratest
  - Security scanning with tfsec and Checkov
  - Automated deployment to dev environment
  - Manual approval process for staging environment
  - Plan output comments on pull requests

## CI/CD Pipeline

This repository includes a GitHub Actions CI/CD pipeline that automates the testing, validation, and deployment of the Terraform infrastructure. The pipeline includes:

### Continuous Integration

- **Terraform Validation**: Validates the syntax and structure of Terraform files
- **Security Scanning**: Scans for security issues using tfsec and Checkov
- **Unit Testing**: Runs unit tests using Terratest

### Continuous Deployment

- **Dev Environment**:
  - Automatically deploys to the dev environment after successful tests
  - Posts plan output as comments on pull requests
- **Staging Environment**:
  - Requires manual approval before deployment
  - Deploys to staging environment after approval

### Running the Pipeline

The pipeline runs automatically on:
- Push to the main branch
- Pull requests to the main branch
- Manual trigger via GitHub Actions interface

### Documentation

For detailed information about the CI/CD pipeline:
- [GitHub Actions Workflow Documentation](.github/workflows/README.md)
- [GitHub Repository Setup Guide](docs/github-setup.md)
- [CI/CD Pipeline Workflow Diagram](docs/cicd-pipeline.md)

## Usage

### 1. Bootstrap State Management Infrastructure

Before deploying the main infrastructure, you need to set up the state management resources:

```bash
cd bootstrap
terraform init
terraform plan
terraform apply
```

This will create an S3 bucket and DynamoDB table for state management.

### 2. Development Environment

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### 3. Staging Environment

```bash
cd environments/staging
terraform init
terraform plan
terraform apply
```

### 4. Running Tests

To run the Terraform unit tests:

```bash
cd tests
go test -v
```

## Module Documentation

### Compute Module

The compute module creates EC2 instances with enhanced configuration options. See the [compute module README](modules/compute/README.md) for detailed documentation.

### Networking Module

The networking module creates VPC, subnet, internet gateway, route table, and security group. See the networking module for details.

### State Module

The state module creates the necessary resources for Terraform state management:
- S3 bucket for storing state files with versioning and encryption
- DynamoDB table for state locking
- Appropriate security configurations and access controls

## Best Practices Implemented

- **Code Structure**: Modular design with clear separation of concerns
- **Variable Validation**: Comprehensive validation for all input variables
- **Tagging Strategy**: Consistent tagging across all resources
- **State Management**: Remote state with proper locking
- **Lifecycle Management**: Prevent accidental destruction and handle changes gracefully
- **Documentation**: Comprehensive documentation for all modules and variables
- **Security**: Encryption for volumes, proper security group configuration
- **Reusability**: Parameterized modules for different environments
- **CI/CD**: Automated testing, validation, and deployment
- **Approval Process**: Manual approval for production-like environments