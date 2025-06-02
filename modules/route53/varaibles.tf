variable "zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
}

variable "record_name" {
  description = "DNS name to create (e.g. www.example.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB Hosted Zone ID (for alias record)"
  type        = string
}
