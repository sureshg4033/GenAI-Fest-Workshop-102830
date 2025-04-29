# Best Practice: Use modules for reusable components
# Compute module - variables.tf

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  
  validation {
    condition     = can(regex("^ami-[a-f0-9]{17}$", var.ami_id))
    error_message = "The ami_id must be a valid AMI ID format (e.g., ami-0c55b159cbfafe1f0)."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z][1-9][.][a-z]+$", var.instance_type))
    error_message = "The instance_type must be a valid EC2 instance type format (e.g., t2.micro, m5.large)."
  }
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs to attach to the instance"
  type        = list(string)
  default     = []
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  
  validation {
    condition     = length(var.instance_name) > 0 && length(var.instance_name) <= 255
    error_message = "The instance_name must be between 1 and 255 characters."
  }
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
  
  validation {
    condition     = contains(["Development", "Staging", "Production"], var.environment)
    error_message = "The environment must be one of: Development, Staging, Production."
  }
}

variable "prefix" {
  description = "Prefix for resource naming"
  type        = string
  default     = "tf"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# New variables for enhanced functionality

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
  
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

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach to the instance"
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
  default     = 8
  
  validation {
    condition     = var.root_volume_size >= 8
    error_message = "The root_volume_size must be at least 8 GB."
  }
}

variable "root_volume_delete_on_termination" {
  description = "Whether to delete the root volume on instance termination"
  type        = bool
  default     = true
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
  default     = false
}

variable "data_volume_size" {
  description = "Size of the data volume in GB"
  type        = number
  default     = 20
  
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

variable "data_volume_device_name" {
  description = "Device name for the data volume"
  type        = string
  default     = "/dev/xvdf"
}