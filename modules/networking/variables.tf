# Best Practice: Use modules for reusable components
# Networking module - variables.tf

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The vpc_cidr must be a valid CIDR block."
  }
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  
  validation {
    condition     = can(cidrnetmask(var.subnet_cidr))
    error_message = "The subnet_cidr must be a valid CIDR block."
  }
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9][a-z]$", var.availability_zone))
    error_message = "The availability_zone must be a valid AZ format (e.g., us-east-1a)."
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