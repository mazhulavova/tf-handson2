output "natgw_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "eip" {
  description = "Elastic IP associated with the NAT Gateway"
  value       = aws_eip.this.public_ip
}
