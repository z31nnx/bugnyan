variable "global_tags" {
  type = map(string)
}

variable "ops_role_name" {
  description = "SSM and CloudWatch role for EC2"
}
