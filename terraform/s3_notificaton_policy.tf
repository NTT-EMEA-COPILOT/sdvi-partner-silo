data "aws_iam_policy_document" "partner_silo_bucket_notification_policy_doc" {
  statement {
    sid    = "__default_statement_ID"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]
    resources = [aws_sns_topic.partner_silo_bucket_notification.arn]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid    = "sdviStmt0001"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    actions = ["SNS:Publish"]
    resources = [aws_sns_topic.partner_silo_bucket_notification.arn]
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [aws_s3_bucket.partner_silo_bucket.arn]
    }
  }
}