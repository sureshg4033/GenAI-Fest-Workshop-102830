# Best Practice: Use modules for reusable components
# Compute module - main.tf

# Local variables for better code organization
locals {
  instance_count = var.instance_count > 0 ? var.instance_count : 1
  
  # Standardized tags for all resources
  instance_tags = merge(
    var.common_tags,
    {
      Name        = var.instance_count > 1 ? "${var.prefix}-${var.instance_name}-\${count.index + 1}" : "${var.prefix}-${var.instance_name}"
      Environment = var.environment
      Module      = "compute"
      ManagedBy   = "Terraform"
    }
  )
}

# Create EC2 instances with count for multiple instances
resource "aws_instance" "instances" {
  count = local.instance_count

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  user_data              = var.user_data
  iam_instance_profile   = var.iam_instance_profile
  
  # Enhanced lifecycle management
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags["LastUpdated"]]
  }

  # Root volume configuration
  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = var.root_volume_delete_on_termination
    encrypted             = var.root_volume_encrypted
    
    tags = merge(
      local.instance_tags,
      {
        Name = var.instance_count > 1 ? "${var.prefix}-${var.instance_name}-\${count.index + 1}-root" : "${var.prefix}-${var.instance_name}-root"
      }
    )
  }

  # Consistent tagging strategy
  tags = merge(
    local.instance_tags,
    {
      LastUpdated = timestamp()
    }
  )
}

# Conditionally create EBS volumes if specified
resource "aws_ebs_volume" "data_volume" {
  count = var.create_data_volume ? local.instance_count : 0
  
  availability_zone = aws_instance.instances[count.index].availability_zone
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = var.data_volume_encrypted
  
  tags = merge(
    local.instance_tags,
    {
      Name = var.instance_count > 1 ? "${var.prefix}-${var.instance_name}-\${count.index + 1}-data" : "${var.prefix}-${var.instance_name}-data"
    }
  )
}

# Attach EBS volumes to instances if created
resource "aws_volume_attachment" "data_volume_attachment" {
  count = var.create_data_volume ? local.instance_count : 0
  
  device_name  = var.data_volume_device_name
  volume_id    = aws_ebs_volume.data_volume[count.index].id
  instance_id  = aws_instance.instances[count.index].id
  
  # Ensure proper detachment before destruction
  stop_instance_before_detaching = true
}