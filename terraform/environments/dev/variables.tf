# Tags
variable "Project" {}
variable "Environment" {}
variable "Owner" {}
variable "Terraform" {}

# VPC
variable "vpc_name" {}
variable "cidr_block" {}

# IAM 
variable "role_name" {}

# Security Groups 
variable "bugnyan_web_asg_sg_name" {}
variable "bugnyan_web_alb_sg_name" {}
variable "bugnyan_app_asg_sg_name" {}
variable "bugnyan_app_alb_sg_name" {}
variable "bugnyan_database_sg_name" {}