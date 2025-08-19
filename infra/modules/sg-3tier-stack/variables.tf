variable "global_tags" { type = map(string) }
variable "sg_name" { type = string }
variable "vpc_id" { type = string }
variable "public_ingress_cidr" {
  description = "CIDRs allowed to the public ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "frontend_alb_ports" {
  type    = list(number)
  default = [80, 443]
}
variable "backend_alb_ports" {
  type    = list(number)
  default = [80]
}
variable "frontend_instance_ports" {
  type    = list(number)
  default = [80]
}
variable "backend_instance_ports" {
  type    = list(number)
  default = [8080]
}
variable "database_port" {
  type    = list(number)
  default = [3306]
}