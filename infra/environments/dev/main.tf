terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

module "s3-stack" {
  source      = "../../modules/s3-static-site-stack"
  global_tags = local.global_tags
}

module "cloudfront-stack" {
  source                                 = "../../modules/cloudfront-stack"
  web_bucket_domain_name                 = module.s3-stack.web_bucket_domain_name
  web_cloudfront_logs_bucket_domain_name = module.s3-stack.web_cloudfront_logs_bucket_domain_name
  global_tags                            = local.global_tags
}

/*
module "vpc-stack" {
  source      = "../../modules/vpc-stack"
  vpc_name    = var.vpc_name
  cidr_block  = var.cidr_block
  global_tags = local.global_tags
}

module "iam-stack" {
  source      = "../../modules/iam-stack"
  ops_role_name   = var.ops_role_name
  global_tags = local.global_tags
}

module "security-group-stack" {
  source                   = "../../modules/security-group-stack"
  web_alb_sg_name  = var.web_alb_sg_name
  web_asg_sg_name  = var.web_asg_sg_name
  app_alb_sg_name  = var.app_alb_sg_name
  app_asg_sg_name  = var.app_asg_sg_name
  database_sg_name = var.database_sg_name
  vpc_id           = module.vpc-stack.bugnyan_vpc_id
  global_tags              = local.global_tags
}

module "launch-template-stack" {
  source                       = "../../modules/launch-template-stack"
  web_launch_template_name     = var.web_launch_template_name
  app_launch_template_name     = var.app_launch_template_name
  app_instance_type    = var.app_instance_type
  web_instance_type    = var.web_instance_type
  iam_instance_profile_for_ec2 = module.iam-stack.iam_instance_profile_name
  global_tags                  = local.global_tags

}

module "alb-stack" {
  source                         = "../../modules/alb-stack"
  app_alb_sg_id          = module.security-group-stack.bugnyan_security_group_details.ids["bugnyan_app_alb_sg"]
  web_alb_sg_id          = module.security-group-stack.bugnyan_security_group_details.ids["bugnyan_web_alb_sg"]
  app_load_balancer_name = var.app_load_balancer_name
  web_load_balancer_name = var.web_load_balancer_name
  vpc_private_subnets    = module.vpc-stack.bugnyan_private_subnets_ids
  vpc_public_subnets     = module.vpc-stack.bugnyan_public_subnets_ids
  vpc_id                 = module.vpc-stack.bugnyan_vpc_id
  global_tags                    = local.global_tags
}
*/