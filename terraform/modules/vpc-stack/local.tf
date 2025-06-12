locals {
  global_tags = var.global_tags
  allow_all   = "0.0.0.0/0"
  public_subnets = {         # main subnets 
    public_subnet_1 = { cidr_block = "10.0.1.0/24", az = "us-east-1a" }
    public_subnet_2 = { cidr_block = "10.0.2.0/24", az = "us-east-1b" }
    public_subnet_3 = { cidr_block = "10.0.3.0/24", az = "us-east-1c" }
  }
  private_subnets = {
    private_subnet_1 = { cidr_block = "10.0.4.0/24", az = "us-east-1a" }
    private_subnet_2 = { cidr_block = "10.0.5.0/24", az = "us-east-1b" }
    private_subnet_3 = { cidr_block = "10.0.6.0/24", az = "us-east-1c" }
  }
  azs = slice(data.aws_availability_zones.available.names, 1, 3)
}

data "aws_availability_zones" "available" {
  state = "available"
}
