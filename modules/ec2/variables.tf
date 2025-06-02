variable "key_name" {
  description = "Name of an existing EC2 key pair"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instances" {
  description = "List of instances with name and subnet_id"
  type = list(object({
    name      = string
    subnet_id = string
  }))
}

variable "security_group_id" {
  description = "Security group to attach"
  type        = string
}
