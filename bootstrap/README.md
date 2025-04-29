# Terraform State Management Bootstrap

This directory contains the Terraform configuration for setting up the state management infrastructure. This needs to be applied before the main infrastructure to create the S3 bucket and DynamoDB table used for remote state storage and locking.

## Resources Created

- **S3 Bucket**: For storing Terraform state files
- **DynamoDB Table**: For state locking to prevent concurrent modifications

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the plan:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. After applying, note the outputs which provide the names of the created resources:
   - `state_bucket_name`: The name of the S3 bucket for state storage
   - `dynamodb_table_name`: The name of the DynamoDB table for state locking

## Configuration

You can customize the following variables:

- `state_bucket_name`: Name of the S3 bucket (default: "terraform-state-bucket")
- `dynamodb_table_name`: Name of the DynamoDB table (default: "terraform-locks")
- `aws_region`: AWS region for the resources (default: "us-east-1")

Example:
```bash
terraform apply -var="state_bucket_name=my-unique-terraform-state" -var="aws_region=us-west-2"
```

## Important Notes

1. The S3 bucket has versioning enabled to protect against accidental state file deletion.
2. The S3 bucket has server-side encryption enabled for security.
3. Public access to the S3 bucket is blocked.
4. The resources have the `prevent_destroy` lifecycle policy to prevent accidental deletion.

## After Bootstrap

Once the state management infrastructure is created, you can proceed to deploy the main infrastructure in the `environments/dev` or `environments/staging` directories. The backend configurations in those environments are already set up to use these state management resources.