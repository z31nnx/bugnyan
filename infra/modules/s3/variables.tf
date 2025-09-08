variable "name_prefix" {
  type = string
}

variable "bucket_names" {
  type = object({
    web        = string
    cloudfront = string
  })
}

