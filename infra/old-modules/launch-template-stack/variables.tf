variable "global_tags" {
  type = map(string)
}

variable "web_launch_template_name" {}
variable "app_launch_template_name" {}

variable "iam_instance_profile_for_ec2" {}
variable "web_instance_type" {}
variable "app_instance_type" {}