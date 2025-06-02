variable "name" {
  description = "Name of the target group"
  type        = string
}

variable "port" {
  description = "Port for target group"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Protocol for target group"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID where the target group is created"
  type        = string
}

variable "health_check_path" {
  description = "Path for health checks"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags for the target group"
  type        = map(string)
  default     = {}
}
