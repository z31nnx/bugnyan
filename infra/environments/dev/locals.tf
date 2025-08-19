locals {
  global_tags = {
    project     = var.project
    environment = var.environment
    owner       = var.owner
    managed_by  = var.managed_by
  }
}