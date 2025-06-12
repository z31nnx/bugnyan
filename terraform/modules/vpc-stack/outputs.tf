output "bugnyan_vpc_id" {
  value = aws_vpc.bugnyan.id
}

output "bugnyan_public_subnets_ids" {
  value = [for s in aws_subnet.bugnyan_public_subnets : s.id]
}

output "bugnyan_private_subnets_ids" {
  value = [for s in aws_subnet.bugnyan_private_subnets : s.id]
}

output "bugnyan_igw_id" {
  value = aws_internet_gateway.bugnyan_igw.id
}

output "bugnyan_natgw_id" {
  value = aws_nat_gateway.bugnyan_natgw.id
}