variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet definitions"
  type = list(object({
    az   = string
    cidr = string
  }))
}

variable "private_subnets" {
  description = "List of private subnet definitions"
  type = list(object({
    az   = string
    cidr = string
  }))
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
