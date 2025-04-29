output "state_bucket_name" {
  description = "The name of the S3 bucket for Terraform state storage"
  value       = module.state.state_bucket_name
}

output "state_bucket_arn" {
  description = "The ARN of the S3 bucket for Terraform state storage"
  value       = module.state.state_bucket_arn
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
  value       = module.state.dynamodb_table_name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table for Terraform state locking"
  value       = module.state.dynamodb_table_arn
}