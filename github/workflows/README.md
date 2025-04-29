# GitHub Actions CI/CD Pipeline for Terraform

This directory contains the GitHub Actions workflow files for the CI/CD pipeline that automates the testing, validation, and deployment of the Terraform infrastructure.

## Workflow Overview

The main workflow file `terraform-cicd.yml` implements a comprehensive CI/CD pipeline for Terraform that includes:

1. **Terraform Validation**: Validates the syntax and structure of Terraform files
2. **Security Scanning**: Scans for security issues using tfsec and Checkov
3. **Unit Testing**: Runs unit tests using Terratest
4. **Plan Generation**: Creates and displays Terraform plans for review
5. **Approval Process**: Requires manual approval before deploying to staging
6. **Infrastructure Deployment**: Deploys the infrastructure to the appropriate environment

## Workflow Triggers

The workflow is triggered by:

- **Push to main branch**: Runs the full pipeline including deployment
- **Pull requests to main branch**: Runs validation, testing, and plan generation
- **Manual trigger**: Allows manual execution with environment selection

## Environment Configuration

The workflow uses GitHub Environments for deployment control:

1. **dev**: Development environment
   - Automatically deployed after successful tests
   - No approval required

2. **staging**: Staging environment
   - Requires manual approval before deployment
   - Protected by environment protection rules

## Required Secrets

The following secrets need to be configured in your GitHub repository:

- `AWS_ACCESS_KEY_ID`: AWS access key with permissions to deploy resources
- `AWS_SECRET_ACCESS_KEY`: AWS secret key paired with the access key

These secrets should be added to both the `dev` and `staging` environments in your GitHub repository settings.

## Environment Protection Rules

To implement the approval process for the staging environment:

1. Go to your GitHub repository
2. Navigate to Settings > Environments
3. Create an environment named `staging`
4. Enable "Required reviewers" and add the appropriate team members
5. Create an environment named `dev` (no required reviewers needed)

## Manual Workflow Execution

To manually trigger the workflow:

1. Go to the Actions tab in your GitHub repository
2. Select the "Terraform CI/CD Pipeline" workflow
3. Click "Run workflow"
4. Select the target environment (dev or staging)
5. Click "Run workflow"

## Workflow Steps

### Terraform Validation

- Checks Terraform formatting
- Validates Terraform syntax
- Ensures all modules and environments are valid

### Security Scanning

- Uses tfsec to scan for security issues
- Uses Checkov to perform additional security checks
- Reports findings as annotations on the workflow

### Unit Testing

- Uses Terratest to run unit tests
- Validates module functionality
- Ensures infrastructure components work as expected

### Plan Generation

- Creates Terraform plans for each environment
- Posts plan outputs as comments on pull requests
- Uploads plans as artifacts for later use

### Approval Process

- Uses GitHub Environments for approval management
- Requires manual approval for staging deployments
- Provides links to review the changes

### Infrastructure Deployment

- Applies the Terraform plans to the appropriate environment
- Ensures bootstrap resources are created first
- Reports deployment status and results

## Customization

To customize the workflow for your needs:

1. Modify the environment names and configurations
2. Adjust the AWS region in the environment variables
3. Add or remove steps as needed
4. Update the Terraform version if required