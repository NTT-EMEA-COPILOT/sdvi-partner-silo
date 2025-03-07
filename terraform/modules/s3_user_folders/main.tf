resource "aws_s3_object" "incoming_folders" {
  bucket       = var.partner_silo_bucket_id
  key          = "${var.user_name}/incoming/"
  content_type = "application/x-directory"
  source       = "/dev/null"
}

resource "aws_s3_object" "processed_folders" {
  bucket       = var.partner_silo_bucket_id
  key          = "${var.user_name}/processed/"
  content_type = "application/x-directory"
  source       = "/dev/null"
}

resource "aws_s3_object" "package_folders" {
  bucket       = var.partner_silo_bucket_id
  key          = "${var.user_name}/package/"
  content_type = "application/x-directory"
  source       = "/dev/null"
}

resource "aws_s3_bucket_notification" "user_incoming_folders_notification" {
  bucket = var.partner_silo_bucket_id

  topic {
    topic_arn = var.partner_silo_bucket_notification_topic_arn
    events    = [
      "s3:ObjectCreated:*",
      "s3:ObjectRemoved:*"
    ]
    filter_prefix = "${var.user_name}/incoming/"
  }
}