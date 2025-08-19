output "vpc_id" {
  value = aws_vpc.bugnyan_vpc.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.bugnyan_public_subnets : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.bugnyan_private_subnets : s.id]
}

output "igw_id" {
  value = try(aws_internet_gateway.bugnyan_igw.id, null)
}

output "natgw_id" {
  value = try(aws_nat_gateway.bugnyan_natgw.id, null)
}
