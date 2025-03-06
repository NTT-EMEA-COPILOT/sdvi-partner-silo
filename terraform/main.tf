provider "aws" {
  ignore_tags {
    keys = ["cost_centre", "environment", "territory", "service", "billing_team"]
  }
  region = var.aws_provider_info.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "sdvi-partner-silo-storage-terraform-state"
    key            = "states/terraform.tfstate"
    region         = "eu-south-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
