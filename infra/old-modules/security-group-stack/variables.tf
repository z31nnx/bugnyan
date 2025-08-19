variable "global_tags" {
  type = map(string)
}

variable "vpc_id" {}

variable "web_asg_sg_name" {}
variable "web_alb_sg_name" {}
variable "app_asg_sg_name" {}
variable "app_alb_sg_name" {}
variable "database_sg_name" {}