resource "aws_sns_topic" "user_incoming_folders_notification" {
  name = "incoming_folders_notification_${var.user_name}"
}

resource "aws_sns_topic_policy" "user_incoming_folders_notification_policy" {
  arn    = aws_sns_topic.user_incoming_folders_notification.arn
  policy = data.aws_iam_policy_document.user_incoming_folders_policy_doc.json
}