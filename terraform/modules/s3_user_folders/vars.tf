data "aws_caller_identity" "current" {}

variable "user_name" {
  type = string
}

variable "partner_silo_bucket_id" {
  type = string
}

variable "partner_silo_bucket_arn" {
  type = string
}
