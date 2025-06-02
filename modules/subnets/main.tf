resource "aws_subnet" "public" {
  for_each = { for subnet in var.public_subnets : subnet.az => subnet }

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge({
    Name = "public-${each.key}"
    Type = "public"
  }, var.tags)
}

resource "aws_subnet" "private" {
  for_each = { for subnet in var.private_subnets : subnet.az => subnet }

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.key

  tags = merge({
    Name = "private-${each.key}"
    Type = "private"
  }, var.tags)
}




