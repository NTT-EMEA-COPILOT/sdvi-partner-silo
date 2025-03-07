data "archive_file" "sns_proxy_lambda_source" {
  type        = "zip"
  source_file = "${path.module}/src/lambda_sns_proxy/main.py"
  output_path = "lambda_sns_proxy.zip"
}

resource "aws_lambda_function" "sns_proxy_lambda" {
  function_name = join("-", [var.project_info.name, var.project_info.env, "sns-proxy"])
  role             = aws_iam_role.lambda_role.arn
  timeout          = 900
  filename         = data.archive_file.sns_proxy_lambda_source.output_path
  source_code_hash = data.archive_file.sns_proxy_lambda_source.output_base64sha256
  handler          = "main.lambda_handler"
  runtime          = "python3.9"

  environment {
    variables = {
      SNS_TOPIC_PREFIX = "arn:aws:sns:${var.aws_provider_info.region}:${data.aws_caller_identity.current.account_id}:${var.project_info.name}"
    }
  }
  tags = {
    Name        = join("-", [var.project_info.name, var.project_info.env, "sns-proxy"])
    Project     = var.project_info["name"]
    Environment = var.project_info["env"]
    Terraform   = "true"
  }
}
