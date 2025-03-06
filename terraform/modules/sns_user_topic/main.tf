resource "aws_sns_topic" "user_topics" {
  name       = var.topic_name
  fifo_topic = false
  tags = {
    Name        = "rally partner silo user topic ${var.topic_name}"
    Project     = var.project_info["name"]
    Environment = var.project_info["env"]
    Terraform   = "true"
  }

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid": "RallySDVIPolicy",
        "Effect": "Allow",
        "Principal": {"AWS":"*"},
        "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
        ],
        "Resource": "arn:aws:sns:*:*:${var.topic_name}",
        "Condition": {
            "ForAllValues:StringEquals": {
                    "AWS:SourceOwner": [
                        "${data.aws_caller_identity.current.account_id}"
                    ]
                }
        }
      }
    ]
}
POLICY

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
}