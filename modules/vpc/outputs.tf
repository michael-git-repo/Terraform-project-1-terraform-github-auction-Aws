output "vpc_id" {
  value       = aws_vpc.my_vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.my_subnet.id
  description = "The ID of the public subnet"
}