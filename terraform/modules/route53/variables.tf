variable "hosted_zone_name" {
  description = "Private Route53 hosted zone name"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for private hosted zone association"
  type        = string
}
