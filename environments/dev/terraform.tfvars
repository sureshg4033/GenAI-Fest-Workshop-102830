# Development environment specific variables
aws_region      = "us-east-1"
vpc_cidr        = "10.0.0.0/16"
subnet_cidr     = "10.0.1.0/24"
availability_zone = "us-east-1a"
instance_type   = "t2.micro"
ami_id          = "ami-0c55b159cbfafe1f0"
instance_name   = "DevWebServer"
environment     = "Development"

common_tags = {
  Project     = "Terraform-EC2-Demo"
  ManagedBy   = "Terraform"
  Environment = "Development"
  Team        = "DevOps"
  CostCenter  = "IT-Dev"
}