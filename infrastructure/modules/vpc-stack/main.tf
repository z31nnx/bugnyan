resource "aws_vpc" "bugnyan" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}"
    }
  )
}

resource "aws_eip" "bugnyan_natgw_eip" {
  domain = "vpc"

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}-natgw-eip"
    }
  )
}

resource "aws_internet_gateway" "bugnyan_igw" {
  vpc_id = aws_vpc.bugnyan.id

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}-igw"
    }
  )
}

resource "aws_nat_gateway" "bugnyan_natgw" {
  allocation_id = aws_eip.bugnyan_natgw_eip.id
  subnet_id     = aws_subnet.bugnyan_public_subnets["public_subnet_1"].id

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}-natgw"
    }
  )
}

resource "aws_subnet" "bugnyan_public_subnets" {
  for_each = local.public_subnets

  vpc_id                                      = aws_vpc.bugnyan.id
  cidr_block                                  = each.value.cidr_block
  availability_zone                           = each.value.az
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}-public-subnet-${each.value.az}"
    }
  )
}

resource "aws_subnet" "bugnyan_private_subnets" {
  for_each = local.private_subnets

  vpc_id                                      = aws_vpc.bugnyan.id
  cidr_block                                  = each.value.cidr_block
  availability_zone                           = each.value.az
  map_public_ip_on_launch                     = false
  enable_resource_name_dns_a_record_on_launch = true

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}-private-subnet-${each.value.az}"
    }
  )
}

resource "aws_route_table" "bugnyan_public_rt" {
  vpc_id = aws_vpc.bugnyan.id

  route {
    cidr_block = local.allow_all
    gateway_id = aws_internet_gateway.bugnyan_igw.id
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}-public-rt"
    }
  )
}

resource "aws_route_table" "bugnyan_private_rt" {
  vpc_id = aws_vpc.bugnyan.id

  route {
    cidr_block     = local.allow_all
    nat_gateway_id = aws_nat_gateway.bugnyan_natgw.id
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.vpc_name}-private-rt"
    }
  )
}

resource "aws_route_table_association" "bugnyan_public_rt_association" {
  for_each = aws_subnet.bugnyan_public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.bugnyan_public_rt.id
}

resource "aws_route_table_association" "bugnyan_private_rt_association" {
  for_each = aws_subnet.bugnyan_private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.bugnyan_private_rt.id
}