variable "global_tags" { type = map(string) }
variable "vpc_name" { type = string }
variable "cidr_block" { type = string }

variable "public_subnets" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  default = {}
}

variable "private_subnets" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  default = {}
}

variable "nat_public_key" {
  description = "The key to place the NAT in a specific subnet"
  default     = "public_subnet_1"
}
