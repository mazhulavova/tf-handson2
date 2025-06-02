variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "public_route_table_id" {
  type        = string
  description = "Public route table ID"
}

variable "private_route_table_id" {
  type        = string
  description = "Private route table ID"
}
