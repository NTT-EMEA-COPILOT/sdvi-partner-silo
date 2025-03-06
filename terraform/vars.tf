data "aws_caller_identity" "current" {}

variable "aws_provider_info" {
  type = map
}

variable "project_info" {
  type = map
}

variable "partner_silo_info" {
  type = map
}

variable "partner_silo_config" {
  type = map
}
