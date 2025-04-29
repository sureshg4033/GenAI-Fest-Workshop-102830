variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state storage"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.state_bucket_name))
    error_message = "The state bucket name must be between 3 and 63 characters, contain only lowercase letters, numbers, and hyphens, and cannot start or end with a hyphen."
  }
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{3,255}$", var.dynamodb_table_name))
    error_message = "The DynamoDB table name must be between 3 and 255 characters and contain only alphanumeric characters, underscores, hyphens, and dots."
  }
}

variable "aws_region" {
  description = "AWS region where the state resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}