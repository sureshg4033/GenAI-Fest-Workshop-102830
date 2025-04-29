# Development Environment Configuration

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Best Practice: Use local values for repeated expressions
locals {
  prefix = "${var.environment}-${var.instance_name}"
  
  # Common tags for all resources
  common_tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      Terraform   = "true"
      Timestamp   = timestamp()
    }
  )
}

# Best Practice: Use modules for reusable components
module "networking" {
  source = "../../modules/networking"

  vpc_cidr         = var.vpc_cidr
  subnet_cidr      = var.subnet_cidr
  availability_zone = var.availability_zone
  environment      = var.environment
  prefix           = local.prefix
  common_tags      = local.common_tags
}

# Use the refactored compute module with enhanced features
module "compute" {
  source = "../../modules/compute"

  # Basic instance configuration
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.networking.subnet_id
  security_group_ids = [module.networking.security_group_id]
  instance_name     = var.instance_name
  environment       = var.environment
  prefix            = local.prefix
  
  # Enhanced features
  instance_count    = var.instance_count
  key_name          = var.key_name
  user_data         = var.user_data
  
  # Root volume configuration
  root_volume_type  = var.root_volume_type
  root_volume_size  = var.root_volume_size
  root_volume_encrypted = var.root_volume_encrypted
  
  # Data volume configuration (if enabled)
  create_data_volume = var.create_data_volume
  data_volume_size   = var.data_volume_size
  data_volume_type   = var.data_volume_type
  data_volume_encrypted = var.data_volume_encrypted
  
  # Common tags
  common_tags       = local.common_tags

  # Best Practice: Use explicit dependencies when needed
  depends_on = [module.networking]
}