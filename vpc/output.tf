output "vpc_id" {
  value = aws_vpc.example_vpc.id
}

output "nsg_id" {
  value = aws_security_group.allow_ssh.id
}

output "sub_id" {
  value = aws_subnet.example_sub.id
}