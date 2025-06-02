variable "public_subnet_id" {
  description = "ID of the public subnet to place the NAT Gateway in"
  type        = string
}

variable "name" {
  description = "Name tag for the NAT Gateway and EIP"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "igw_id" {
  description = "ID of the Internet Gateway (used for dependency)"
  type        = string
}
