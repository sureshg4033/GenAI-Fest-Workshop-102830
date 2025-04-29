# GitHub Repository Setup for CI/CD Pipeline

This guide explains how to configure your GitHub repository settings to enable the CI/CD pipeline for Terraform infrastructure deployment.

## 1. Configure GitHub Environments

GitHub Environments are used to implement the approval process and manage environment-specific secrets.

### Create Development Environment

1. Go to your GitHub repository
2. Navigate to **Settings** > **Environments**
3. Click **New environment**
4. Enter `dev` as the name
5. Click **Configure environment**
6. Add the following secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key for the development account
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key for the development account
7. Leave the protection rules disabled for automatic deployment

### Create Staging Environment

1. Go to your GitHub repository
2. Navigate to **Settings** > **Environments**
3. Click **New environment**
4. Enter `staging` as the name
5. Click **Configure environment**
6. Enable **Required reviewers** and add the appropriate team members or individuals who should approve deployments
7. Add the following secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key for the staging account
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key for the staging account
8. Optionally, configure **Deployment branches** to restrict which branches can deploy to this environment

## 2. Configure Branch Protection Rules

To ensure code quality and prevent direct pushes to the main branch:

1. Go to your GitHub repository
2. Navigate to **Settings** > **Branches**
3. Click **Add rule** under "Branch protection rules"
4. Enter `main` in the "Branch name pattern" field
5. Enable the following options:
   - **Require pull request reviews before merging**
   - **Require status checks to pass before merging**
   - **Require branches to be up to date before merging**
6. Under "Status checks that are required", add:
   - `terraform-validate`
   - `terraform-security`
   - `terraform-unit-tests`
7. Click **Create** or **Save changes**

## 3. Configure Repository Secrets

For secrets that are used across all environments:

1. Go to your GitHub repository
2. Navigate to **Settings** > **Secrets and variables** > **Actions**
3. Click **New repository secret**
4. Add any additional secrets needed for your specific setup

## 4. Enable GitHub Actions

Ensure GitHub Actions are enabled for your repository:

1. Go to your GitHub repository
2. Navigate to **Settings** > **Actions** > **General**
3. Select **Allow all actions and reusable workflows**
4. Click **Save**

## 5. Initial Workflow Run

To initialize the workflow:

1. Go to the **Actions** tab in your GitHub repository
2. Select the "Terraform CI/CD Pipeline" workflow
3. Click **Run workflow**
4. Select `dev` as the environment
5. Click **Run workflow**

## 6. Monitoring and Troubleshooting

- Monitor workflow runs in the **Actions** tab
- Check workflow logs for any errors
- Review pull request comments for Terraform plan outputs
- Verify environment deployments through the GitHub Environments interface

## 7. Best Practices

- Always create a pull request for infrastructure changes
- Review Terraform plans carefully before approving
- Use meaningful commit messages to track changes
- Add detailed descriptions to pull requests explaining the changes
- Set up notifications for workflow failures and required approvals