resource "aws_eip" "this" {
  domain = "vpc"

  tags = merge({
    Name = "${var.name}-eip"
  }, var.tags)
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.public_subnet_id

  tags = merge({
    Name = var.name
  }, var.tags)

}
