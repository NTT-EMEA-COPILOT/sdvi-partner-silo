resource "aws_s3_bucket" "partner_silo_bucket" {
  bucket = var.partner_silo_info.bucket_name
  tags = {
    Name        = var.partner_silo_info.bucket_name
    Project     = var.project_info["name"]
    Environment = var.project_info["env"]
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_ownership_controls" "partner_silo_bucket_acl_ownership" {
  bucket = aws_s3_bucket.partner_silo_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_versioning" "partner_silo_bucket_versioning" {
  bucket = aws_s3_bucket.partner_silo_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "partner_silo_bucket_acl" {
  bucket = aws_s3_bucket.partner_silo_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "partner_silo_bucket_config" {
  bucket = aws_s3_bucket.partner_silo_bucket.id

  rule {
    id     = "expire-after-60-days"
    status = "Enabled"

    expiration {
      days = var.partner_silo_info.default_expiration_days
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = var.partner_silo_info.abort_multipart_expiration_days
    }
  }
}