data "aws_caller_identity" "current" {}

variable "topic_name" {
  type = string
}

variable "sdvi_managed_account" {
  type = string
}

variable "project_info" {
  type = map
}

