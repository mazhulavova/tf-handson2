
# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge({
    Name = "${var.name_prefix}-public"
  }, var.tags)
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table_association" "public" {
  for_each       = toset(var.public_subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = merge({
    Name = "${var.name_prefix}-private"
  }, var.tags)
}

resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.natgw_id
}

resource "aws_route_table_association" "private" {
  for_each       = toset(var.private_subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
