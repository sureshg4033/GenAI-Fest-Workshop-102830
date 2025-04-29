# Best Practice: Follow consistent naming conventions and code structure
# Outputs file

# Basic outputs for backward compatibility
output "instance_id" {
  description = "ID of the first EC2 instance"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the first EC2 instance"
  value       = module.compute.instance_public_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.networking.subnet_id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.networking.security_group_id
}

# Enhanced outputs for multiple instances
output "instance_ids" {
  description = "List of IDs of the EC2 instances"
  value       = module.compute.instance_ids
}

output "instance_public_ips" {
  description = "List of public IP addresses of the EC2 instances"
  value       = module.compute.instance_public_ips
}

output "instance_private_ips" {
  description = "List of private IP addresses of the EC2 instances"
  value       = module.compute.instance_private_ips
}

output "instance_states" {
  description = "List of states of the EC2 instances"
  value       = module.compute.instance_states
}

output "availability_zones" {
  description = "List of availability zones of the EC2 instances"
  value       = module.compute.availability_zones
}

# Data volume outputs
output "data_volume_ids" {
  description = "List of IDs of the data volumes (if created)"
  value       = module.compute.data_volume_ids
}

# Detailed instance information
output "instance_details" {
  description = "Map of instance details with instance ID as key"
  value       = module.compute.instance_details
}