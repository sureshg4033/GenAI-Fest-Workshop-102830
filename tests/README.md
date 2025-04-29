# Terraform Unit Tests

This directory contains unit tests for the Terraform modules and environments using [Terratest](https://terratest.gruntwork.io/).

## Prerequisites

- Go 1.20 or later
- Terraform 1.5.0 or later
- AWS credentials configured (for running tests that interact with AWS)

## Running Tests

To run all tests:

```bash
cd tests
go test -v
```

To run a specific test:

```bash
cd tests
go test -v -run TestTerraformBootstrap
```

## Test Coverage

The tests cover:

1. **Bootstrap Module**: Verifies that the S3 bucket and DynamoDB table for state management are properly configured.
2. **Dev Environment**: Validates the dev environment configuration and ensures it includes the networking and compute modules.
3. **Staging Environment**: Validates the staging environment configuration and ensures it includes the networking and compute modules.
4. **Individual Modules**: Tests each module (networking, compute, state) for syntax and validation errors.

## Adding New Tests

To add new tests:

1. Create a new test function in `terraform_test.go` following the naming convention `Test*`.
2. Use the Terratest library to interact with Terraform.
3. Add assertions to verify the expected behavior.

## CI/CD Integration

These tests are automatically run as part of the CI/CD pipeline in GitHub Actions. See the workflow file at `.github/workflows/terraform-cicd.yml` for details.