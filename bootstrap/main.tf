# Bootstrap Configuration for State Management
# This configuration creates the necessary resources for Terraform state management

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Local values
locals {
  common_tags = {
    Project     = "Terraform AWS EC2 Infrastructure"
    ManagedBy   = "Terraform"
    Environment = "Bootstrap"
    Terraform   = "true"
    Timestamp   = timestamp()
  }
}

# Use the state module to create state management resources
module "state" {
  source = "../modules/state"

  state_bucket_name    = var.state_bucket_name
  dynamodb_table_name  = var.dynamodb_table_name
  aws_region           = var.aws_region
  common_tags          = local.common_tags
}