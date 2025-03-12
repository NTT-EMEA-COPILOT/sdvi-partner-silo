resource "aws_s3_bucket_lifecycle_configuration" "partner_silo_bucket_config" {
  bucket = aws_s3_bucket.partner_silo_bucket.id

  rule {
    id     = "artner_silo_bucket-housekeeping-rule"
    status = "Enabled"

    expiration {
      days = var.partner_silo_info.default_expiration_days
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = var.partner_silo_info.abort_multipart_expiration_days
    }
  }
}