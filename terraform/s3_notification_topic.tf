resource "aws_sns_topic" "partner_silo_bucket_notification" {
  name = "sdvi-notify-${aws_s3_bucket.partner_silo_bucket.id}"
}

resource "aws_sns_topic_policy" "user_incoming_folders_notification_policy" {
  arn    = aws_sns_topic.partner_silo_bucket_notification.arn
  policy = data.aws_iam_policy_document.partner_silo_bucket_notification_policy_doc.json
}