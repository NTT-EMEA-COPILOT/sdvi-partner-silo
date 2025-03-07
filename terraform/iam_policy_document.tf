data "aws_iam_policy_document" "partner_silo_assume_role_policy_doc" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${var.partner_silo_info.sdvi_managed_account}:root"
      ]
    }
    effect = "Allow"
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values = [var.partner_silo_info.sdvi_external_id]
    }
  }
}

data "aws_iam_policy_document" "partner_silo_policy_doc" {
  statement {
    sid = "listBucketsPolicy"
    actions = [
      "iam:SimulatePrincipalPolicy",
      "s3:HeadBucket",
      "s3:ListAllMyBuckets"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "snsSubscriptionPolicy"
    actions = [
      "SNS:ListSubscriptionsByTopic",
      "SNS:Subscribe"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:sns:${var.aws_provider_info.region}:${data.aws_caller_identity.current.account_id}:sdvi-notify-${aws_s3_bucket.partner_silo_bucket.id}",
      "arn:aws:sns:${var.aws_provider_info.region}:${data.aws_caller_identity.current.account_id}:sdvi-partner-silo-topic-1-*",
      "arn:aws:sns:${var.aws_provider_info.region}:${data.aws_caller_identity.current.account_id}:sdvi-partner-silo-topic-2-*"
    ]
  }
  statement {
    sid = "bucketAccessPolicy"
    actions = [
      "s3:DeleteObjectTagging",
      "s3:ListBucketMultipartUploads",
      "s3:DeleteObjectVersion",
      "s3:ListBucketVersions",
      "s3:RestoreObject",
      "s3:ListBucket",
      "s3:GetBucketNotification",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:AbortMultipartUpload",
      "s3:PutObjectVersionAcl",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:PutObjectAcl",
      "s3:GetObjectVersion"
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.partner_silo_bucket.arn}",
      "${aws_s3_bucket.partner_silo_bucket.arn}/*"
    ]
  }
}