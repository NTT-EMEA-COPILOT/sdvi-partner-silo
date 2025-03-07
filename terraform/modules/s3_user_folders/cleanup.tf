resource "aws_s3_bucket_lifecycle_configuration" "partner_silo_bucket_config" {
  bucket = var.partner_silo_bucket_id

  rule {
    id     = "housekeeping-rule-${var.user_name}"
    status = "Enabled"

    filter {
      prefix = "${var.user_name}/"
    }

    expiration {
      days = var.default_expiration_days
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = var.abort_multipart_expiration_days
    }
  }
}