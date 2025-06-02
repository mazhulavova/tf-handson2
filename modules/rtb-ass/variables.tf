variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_route_table_id" {
  description = "ID of the public route table"
  type        = string
}

variable "private_route_table_id" {
  description = "ID of the private route table"
  type        = string
}
