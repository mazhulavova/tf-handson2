resource "aws_route_table_association" "public" {
  for_each = {
    for subnet_id in var.public_subnet_ids : subnet_id => {
      subnet_id       = subnet_id
      route_table_id  = var.public_route_table_id
    }
  }

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
}

resource "aws_route_table_association" "private" {
  for_each = {
    for subnet_id in var.private_subnet_ids : subnet_id => {
      subnet_id       = subnet_id
      route_table_id  = var.private_route_table_id
    }
  }

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
}
