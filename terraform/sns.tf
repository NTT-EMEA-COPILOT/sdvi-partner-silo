resource "aws_sns_topic" "user_topics" {
  for_each = toset(var.partner_silo_config.user_names)

  name       = "${each.value}_topic_1"
  fifo_topic = false
  tags = {
    Name        = "rally partner silo user topic ${each.value}_topic_1"
    Project     = var.project_info["name"]
    Environment = var.project_info["env"]
    Terraform   = "true"
  }

  # Optional: Set delivery policy
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