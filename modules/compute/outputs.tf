# Best Practice: Use modules for reusable components
# Compute module - outputs.tf

output "instance_ids" {
  description = "List of IDs of the EC2 instances"
  value       = aws_instance.instances[*].id
}

output "instance_arns" {
  description = "List of ARNs of the EC2 instances"
  value       = aws_instance.instances[*].arn
}

output "instance_public_ips" {
  description = "List of public IP addresses of the EC2 instances"
  value       = aws_instance.instances[*].public_ip
}

output "instance_private_ips" {
  description = "List of private IP addresses of the EC2 instances"
  value       = aws_instance.instances[*].private_ip
}

output "instance_states" {
  description = "List of states of the EC2 instances"
  value       = aws_instance.instances[*].instance_state
}

output "availability_zones" {
  description = "List of availability zones of the EC2 instances"
  value       = aws_instance.instances[*].availability_zone
}

output "primary_network_interface_ids" {
  description = "List of IDs of the primary network interfaces"
  value       = aws_instance.instances[*].primary_network_interface_id
}

# For backward compatibility with existing code
output "instance_id" {
  description = "ID of the first EC2 instance (for backward compatibility)"
  value       = length(aws_instance.instances) > 0 ? aws_instance.instances[0].id : null
}

output "instance_public_ip" {
  description = "Public IP address of the first EC2 instance (for backward compatibility)"
  value       = length(aws_instance.instances) > 0 ? aws_instance.instances[0].public_ip : null
}

output "instance_private_ip" {
  description = "Private IP address of the first EC2 instance (for backward compatibility)"
  value       = length(aws_instance.instances) > 0 ? aws_instance.instances[0].private_ip : null
}

output "instance_state" {
  description = "Current state of the first EC2 instance (for backward compatibility)"
  value       = length(aws_instance.instances) > 0 ? aws_instance.instances[0].instance_state : null
}

# Data volume outputs
output "data_volume_ids" {
  description = "List of IDs of the data volumes (if created)"
  value       = var.create_data_volume ? aws_ebs_volume.data_volume[*].id : []
}

# Instance details as a map for easier consumption
output "instance_details" {
  description = "Map of instance details with instance ID as key"
  value = {
    for idx, instance in aws_instance.instances : instance.id => {
      public_ip     = instance.public_ip
      private_ip    = instance.private_ip
      instance_type = instance.instance_type
      state         = instance.instance_state
      az            = instance.availability_zone
      subnet_id     = instance.subnet_id
      ami           = instance.ami
      tags          = instance.tags
    }
  }
}