variable "global_tags" {
  type = map(string)
}

variable "bucket_names" {
  type = map(string)
  default = {
    "web"        = "bugnyan-web"
    "cloudfront" = "bugnyan-web-cloudfront"
  }
}

