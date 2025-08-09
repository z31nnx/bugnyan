variable "global_tags" {
  type = map(string)
}

# Vpc outputs 
variable "bugnyan_vpc_id" {} # from the vpc module 
variable "bugnyan_vpc_public_subnets" {}
variable "bugnyan_vpc_private_subnets" {}

# sg outputs 
variable "bugnyan_web_alb_sg_id" {} # from the security groups module 
variable "bugnyan_app_alb_sg_id" {}



# alb 
variable "bugnyan_web_load_balancer_name" {}
variable "bugnyan_app_load_balancer_name" {}