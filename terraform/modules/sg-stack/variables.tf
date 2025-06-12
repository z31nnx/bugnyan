variable "global_tags" {
  type = map(string)
}

variable "bugnyan_vpc_id" {}

variable "bugnyan_web_asg_sg_name" {}
variable "bugnyan_web_alb_sg_name" {}
variable "bugnyan_app_asg_sg_name" {}
variable "bugnyan_app_alb_sg_name" {}
variable "bugnyan_database_sg_name" {}