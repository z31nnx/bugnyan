# Tags
variable "project" {}
variable "environment" {}
variable "owner" {}
variable "managed_by" {}

# VPC
variable "vpc_name" {}
variable "cidr_block" {}

# IAM 
variable "ops_role_name" {}

# Security Groups 
variable "web_asg_sg_name" {}
variable "web_alb_sg_name" {}
variable "app_asg_sg_name" {}
variable "app_alb_sg_name" {}
variable "database_sg_name" {}

# Launch templates 
variable "web_launch_template_name" {}
variable "app_launch_template_name" {}
variable "web_instance_type" {}
variable "app_instance_type" {}

# Application load balancers 
variable "web_load_balancer_name" {}
variable "app_load_balancer_name" {}
