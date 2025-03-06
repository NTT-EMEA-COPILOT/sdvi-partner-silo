resource "aws_s3_object" "incoming_folders" {
  for_each = toset(var.partner_silo_config.user_names)

  bucket       = aws_s3_bucket.partner_silo_bucket.id
  key          = "${each.value}/incoming"
  content_type = "application/x-directory"
  source       = "/dev/null"
}

resource "aws_s3_object" "processed_folders" {
  for_each = toset(var.partner_silo_config.user_names)

  bucket       = aws_s3_bucket.partner_silo_bucket.id
  key          = "${each.value}/processed"
  content_type = "application/x-directory"
  source       = "/dev/null"
}