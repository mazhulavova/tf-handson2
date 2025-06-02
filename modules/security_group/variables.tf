variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the SG will be created"
  type        = string
}

variable "ssh_cidr_blocks" {
  description = "List of CIDRs allowed to SSH (port 22)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
  default     = {}
}
