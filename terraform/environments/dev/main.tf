terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

module "vpc-stack" {
  source      = "../../modules/vpc-stack"
  vpc_name    = var.vpc_name
  cidr_block  = var.cidr_block
  global_tags = local.global_tags
}

module "iam-stack" {
  source      = "../../modules/iam-stack"
  role_name   = var.role_name
  global_tags = local.global_tags
}

module "security-group-stack" {
  source                   = "../../modules/security-group-stack"
  bugnyan_web_alb_sg_name  = var.bugnyan_web_alb_sg_name
  bugnyan_web_asg_sg_name  = var.bugnyan_web_asg_sg_name
  bugnyan_app_alb_sg_name  = var.bugnyan_app_alb_sg_name
  bugnyan_app_asg_sg_name  = var.bugnyan_app_asg_sg_name
  bugnyan_database_sg_name = var.bugnyan_database_sg_name
  bugnyan_vpc_id           = module.vpc-stack.bugnyan_vpc_id
  global_tags              = local.global_tags
}

module "launch-template-stack" {
  source                       = "../../modules/launch-template-stack"
  web_launch_template_name     = var.web_launch_template_name
  app_launch_template_name     = var.app_launch_template_name
  bugnyan_app_instance_type    = var.bugnyan_app_instance_type
  bugnyan_web_instance_type    = var.bugnyan_web_instance_type
  iam_instance_profile_for_ec2 = module.iam-stack.iam_instance_profile_name
  global_tags                  = local.global_tags

}

module "alb-stack" {
  source                         = "../../modules/alb-stack"
  bugnyan_app_alb_sg_id          = module.security-group-stack.bugnyan_security_group_details.ids["bugnyan_app_alb_sg"]
  bugnyan_web_alb_sg_id          = module.security-group-stack.bugnyan_security_group_details.ids["bugnyan_web_alb_sg"]
  bugnyan_app_load_balancer_name = var.bugnyan_app_load_balancer_name
  bugnyan_web_load_balancer_name = var.bugnyan_web_load_balancer_name
  bugnyan_vpc_private_subnets    = module.vpc-stack.bugnyan_private_subnets_ids
  bugnyan_vpc_public_subnets     = module.vpc-stack.bugnyan_public_subnets_ids
  bugnyan_vpc_id                 = module.vpc-stack.bugnyan_vpc_id
  global_tags                    = local.global_tags
}