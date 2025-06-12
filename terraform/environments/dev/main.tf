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

module "sg-stack" {
  source                   = "../../modules/sg-stack"
  bugnyan_web_alb_sg_name  = var.bugnyan_web_alb_sg_name
  bugnyan_web_asg_sg_name  = var.bugnyan_web_asg_sg_name
  bugnyan_app_alb_sg_name  = var.bugnyan_app_alb_sg_name
  bugnyan_app_asg_sg_name  = var.bugnyan_app_asg_sg_name
  bugnyan_database_sg_name = var.bugnyan_database_sg_name
  bugnyan_vpc_id           = module.vpc-stack.bugnyan_vpc_id
  global_tags              = local.global_tags
}