# Compute Module

This module creates EC2 instances in AWS with enhanced modularity and state management.

## Features

- Support for creating multiple instances with the same configuration
- Configurable root volume settings (size, type, encryption)
- Optional data volume creation and attachment
- Enhanced lifecycle management
- Comprehensive tagging strategy
- Support for user data scripts and IAM instance profiles
- Detailed output information for better state management

## Resources Created

- EC2 instances with specified AMI and instance type
- Instances are created in the specified subnet with the specified security groups
- Optional EBS data volumes with configurable settings
- Volume attachments for data volumes

## Usage

### Basic Usage

```hcl
module "compute" {
  source = "../../modules/compute"

  ami_id            = "ami-0c55b159cbfafe1f0"
  instance_type     = "t2.micro"
  subnet_id         = module.networking.subnet_id
  security_group_ids = [module.networking.security_group_id]
  instance_name     = "WebServer"
  environment       = "Development"
  prefix            = "myapp"
  common_tags       = {
    Project     = "MyProject"
    ManagedBy   = "Terraform"
  }
}
```

### Advanced Usage with Multiple Instances and Data Volumes

```hcl
module "compute" {
  source = "../../modules/compute"

  ami_id            = "ami-0c55b159cbfafe1f0"
  instance_type     = "t2.medium"
  subnet_id         = module.networking.subnet_id
  security_group_ids = [module.networking.security_group_id]
  instance_name     = "AppServer"
  environment       = "Production"
  prefix            = "myapp"
  
  # Create multiple instances
  instance_count    = 3
  
  # Configure SSH key
  key_name          = "my-ssh-key"
  
  # Configure root volume
  root_volume_type  = "gp3"
  root_volume_size  = 20
  root_volume_encrypted = true
  
  # Add data volume
  create_data_volume = true
  data_volume_size   = 100
  data_volume_type   = "gp3"
  data_volume_encrypted = true
  
  # Add user data script
  user_data         = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
  EOF
  
  # Add IAM instance profile
  iam_instance_profile = "MyInstanceProfile"
  
  common_tags       = {
    Project     = "MyProject"
    ManagedBy   = "Terraform"
    Department  = "DevOps"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| ami_id | AMI ID for the EC2 instance | string | n/a | yes |
| instance_type | EC2 instance type | string | n/a | yes |
| subnet_id | Subnet ID where the instance will be launched | string | n/a | yes |
| security_group_ids | List of Security Group IDs to attach to the instance | list(string) | [] | no |
| instance_name | Name tag for the EC2 instance | string | n/a | yes |
| environment | Environment tag for resources | string | n/a | yes |
| prefix | Prefix for resource naming | string | "tf" | no |
| common_tags | Common tags to apply to all resources | map(string) | {} | no |
| instance_count | Number of instances to create | number | 1 | no |
| key_name | Name of the SSH key pair to use for the instance | string | null | no |
| user_data | User data script for instance initialization | string | null | no |
| iam_instance_profile | IAM instance profile name to attach to the instance | string | null | no |
| root_volume_type | Type of the root volume (gp2, gp3, io1, io2, etc.) | string | "gp3" | no |
| root_volume_size | Size of the root volume in GB | number | 8 | no |
| root_volume_delete_on_termination | Whether to delete the root volume on instance termination | bool | true | no |
| root_volume_encrypted | Whether to encrypt the root volume | bool | true | no |
| create_data_volume | Whether to create and attach a data volume | bool | false | no |
| data_volume_size | Size of the data volume in GB | number | 20 | no |
| data_volume_type | Type of the data volume (gp2, gp3, io1, io2, etc.) | string | "gp3" | no |
| data_volume_encrypted | Whether to encrypt the data volume | bool | true | no |
| data_volume_device_name | Device name for the data volume | string | "/dev/xvdf" | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_ids | List of IDs of the EC2 instances |
| instance_arns | List of ARNs of the EC2 instances |
| instance_public_ips | List of public IP addresses of the EC2 instances |
| instance_private_ips | List of private IP addresses of the EC2 instances |
| instance_states | List of states of the EC2 instances |
| availability_zones | List of availability zones of the EC2 instances |
| primary_network_interface_ids | List of IDs of the primary network interfaces |
| instance_id | ID of the first EC2 instance (for backward compatibility) |
| instance_public_ip | Public IP address of the first EC2 instance (for backward compatibility) |
| instance_private_ip | Private IP address of the first EC2 instance (for backward compatibility) |
| instance_state | Current state of the first EC2 instance (for backward compatibility) |
| data_volume_ids | List of IDs of the data volumes (if created) |
| instance_details | Map of instance details with instance ID as key |