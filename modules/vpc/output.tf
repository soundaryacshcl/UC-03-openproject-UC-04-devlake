output "name" {
  value = aws_vpc.main.tags["Name"]
}
output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}
