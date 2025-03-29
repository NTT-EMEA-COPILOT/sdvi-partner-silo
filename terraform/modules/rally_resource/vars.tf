data "aws_caller_identity" "current" {}

variable "user_name" {
  type = string
}

variable "rally_api_key" {
  type = string
}
