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