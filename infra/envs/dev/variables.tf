# Global Tags
variable "project" {
  type = string
}
variable "environment" {
  type = string
}
variable "owner" {
  type = string
}
variable "managedby" {
  type = string
}

variable "region" {
  type = string
}

# S3 Variables
variable "bucket_names" {
  type = object({
    web        = string
    cloudfront = string
  })
}
# CloudFront Variables

variable "origin_id" {
  type = string
}

variable "oac_name" {
  type = string
}