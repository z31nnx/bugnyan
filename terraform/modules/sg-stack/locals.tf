locals {
  global_tags = var.global_tags
  ports = {
    web      = [80, 443]
    app      = [8080]
    database = [3306]
  }
}