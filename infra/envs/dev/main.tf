terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      project     = var.project
      environment = var.environment
      owner       = var.owner
      managedby   = var.managedby
    }
  }
}

module "s3" {
  source       = "../../modules/s3"
  bucket_names = var.bucket_names
  name_prefix  = local.name_prefix
}

module "cloudfront" {
  source                             = "../../modules/cloudfront"
  oac_name                           = var.oac_name
  origin_id                          = var.origin_id
  bucket_names                       = module.s3.bucket_names["web"]
  bucket_arns                        = module.s3.bucket_arns["web"]
  web_bucket_regional_domain_name    = module.s3.bucket_regional_domain_names["web"]
  cloudfront_logs_bucket_domain_name = module.s3.bucket_domain_names["cloudfront"]
  name_prefix                        = local.name_prefix
  depends_on                         = [module.s3]
}
