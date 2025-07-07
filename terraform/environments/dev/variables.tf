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

# Launch templates 
variable "web_launch_template_name" {}
variable "app_launch_template_name" {}
variable "bugnyan_web_instance_type" {}
variable "bugnyan_app_instance_type" {}

# Application load balancers 
variable "bugnyan_web_load_balancer_name" {}
variable "bugnyan_app_load_balancer_name" {}