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
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "partner_silo_bucket_versioning" {
  bucket = aws_s3_bucket.partner_silo_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "partner_silo_bucket_access" {
  bucket                  = aws_s3_bucket.partner_silo_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "partner_silo_bucket_acl" {
  bucket = aws_s3_bucket.partner_silo_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_cors_configuration" "partner_silo_bucket_cors" {
  bucket = aws_s3_bucket.partner_silo_bucket.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "HEAD", "GET", "DELETE"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
    max_age_seconds = 3000
  }
  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_notification" "user_incoming_folders_notification" {
  bucket = aws_s3_bucket.partner_silo_bucket.id

  topic {
    topic_arn = aws_sns_topic.partner_silo_bucket_notification.arn
    events    = [
      "s3:ObjectCreated:*",
      "s3:ObjectRemoved:*"
    ]
  }
}