locals {
  global_tags = {
    Project     = var.Project
    Environment = var.Environment
    Owner       = var.Owner
    Terraform   = var.Terraform
  }
}