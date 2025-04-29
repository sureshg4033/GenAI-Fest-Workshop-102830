# Networking Module

This module creates the networking infrastructure required for deploying EC2 instances in AWS.

## Resources Created

- VPC with DNS support
- Public subnet with auto-assign public IP
- Internet Gateway
- Route Table with route to the Internet Gateway
- Security Group allowing SSH access

## Usage

```hcl
module "networking" {
  source = "../../modules/networking"

  vpc_cidr         = "10.0.0.0/16"
  subnet_cidr      = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  environment      = "Development"
  prefix           = "myapp"
  common_tags      = {
    Project     = "MyProject"
    ManagedBy   = "Terraform"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vpc_cidr | CIDR block for the VPC | string | n/a | yes |
| subnet_cidr | CIDR block for the subnet | string | n/a | yes |
| availability_zone | Availability Zone for the subnet | string | n/a | yes |
| environment | Environment tag for resources | string | n/a | yes |
| prefix | Prefix for resource naming | string | "tf" | no |
| common_tags | Common tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| subnet_id | ID of the subnet |
| security_group_id | ID of the security group |
| vpc_cidr | CIDR block of the VPC |
| subnet_cidr | CIDR block of the subnet |