variable "global_tags" {
  type = map(string)
}

# Vpc outputs 
variable "vpc_id" {} # from the vpc module 
variable "vpc_public_subnets" {}
variable "vpc_private_subnets" {}

# sg outputs 
variable "web_alb_sg_id" {} # from the security groups module 
variable "app_alb_sg_id" {}



# alb 
variable "web_load_balancer_name" {}
variable "app_load_balancer_name" {}