# Best Practice: Implement proper variable validation
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
  
  validation {
    condition     = can(regex("^(us|eu|ap|sa|ca|me|af)-(north|south|east|west|central)-[1-3]$", var.aws_region))
    error_message = "The aws_region must be a valid AWS region format (e.g., us-east-1, eu-west-1)."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
  
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The vpc_cidr must be a valid CIDR block."
  }
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.1.1.0/24"
  
  validation {
    condition     = can(cidrnetmask(var.subnet_cidr))
    error_message = "The subnet_cidr must be a valid CIDR block."
  }
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
  default     = "us-east-1a"
  
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9][a-z]$", var.availability_zone))
    error_message = "The availability_zone must be a valid AZ format (e.g., us-east-1a)."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
  
  validation {
    condition     = can(regex("^[a-z][1-9][.][a-z]+$", var.instance_type))
    error_message = "The instance_type must be a valid EC2 instance type format (e.g., t2.micro, m5.large)."
  }
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  
  validation {
    condition     = can(regex("^ami-[a-f0-9]{17}$", var.ami_id))
    error_message = "The ami_id must be a valid AMI ID format (e.g., ami-0c55b159cbfafe1f0)."
  }
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "WebServer"
  
  validation {
    condition     = length(var.instance_name) > 0 && length(var.instance_name) <= 255
    error_message = "The instance_name must be between 1 and 255 characters."
  }
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
  default     = "Staging"
  
  validation {
    condition     = contains(["Development", "Staging", "Production"], var.environment)
    error_message = "The environment must be one of: Development, Staging, Production."
  }
}

# Best Practice: Define common tags as a variable
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {
    Project     = "Terraform-EC2-Demo"
    ManagedBy   = "Terraform"
    Environment = "Staging"
  }
}

# New variables for enhanced EC2 instance configuration

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2  # Default to 2 instances for staging
  
  validation {
    condition     = var.instance_count >= 0
    error_message = "The instance_count must be a non-negative number."
  }
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instance"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script for instance initialization"
  type        = string
  default     = null
}

# Root volume configuration
variable "root_volume_type" {
  description = "Type of the root volume (gp2, gp3, io1, io2, etc.)"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20  # Larger root volume for staging
  
  validation {
    condition     = var.root_volume_size >= 8
    error_message = "The root_volume_size must be at least 8 GB."
  }
}

variable "root_volume_encrypted" {
  description = "Whether to encrypt the root volume"
  type        = bool
  default     = true
}

# Data volume configuration
variable "create_data_volume" {
  description = "Whether to create and attach a data volume"
  type        = bool
  default     = true  # Enable data volume by default for staging
}

variable "data_volume_size" {
  description = "Size of the data volume in GB"
  type        = number
  default     = 50  # Larger data volume for staging
  
  validation {
    condition     = var.data_volume_size >= 1
    error_message = "The data_volume_size must be at least 1 GB."
  }
}

variable "data_volume_type" {
  description = "Type of the data volume (gp2, gp3, io1, io2, etc.)"
  type        = string
  default     = "gp3"
}

variable "data_volume_encrypted" {
  description = "Whether to encrypt the data volume"
  type        = bool
  default     = true
}