variable "name" {
  description = "Name of the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ACM Certificate ARN for HTTPS listener"
  type        = string
  default     = ""
}

variable "target_group_arn" {
  description = "Target group to forward traffic to"
  type        = string
}

variable "enable_https" {
  description = "Enable HTTPS listener"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
