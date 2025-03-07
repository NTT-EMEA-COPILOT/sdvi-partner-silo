resource "aws_api_gateway_rest_api" "partner_silo_api_gateway" {
  name = join("-", [var.project_info["name"], var.project_info["env"], "api-gw"])

  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = {
    Name = join("-", [var.project_info["name"], var.project_info["env"], "api-gw"])
    Project     = var.project_info["name"]
    Environment = var.project_info["env"]
    Terraform   = "true"
  }
}

resource "aws_api_gateway_resource" "sns_proxy" {
  rest_api_id = aws_api_gateway_rest_api.partner_silo_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.partner_silo_api_gateway.root_resource_id
  path_part   = "sns-proxy"
}

resource "aws_api_gateway_method" "sns_proxy_method" {
  rest_api_id      = aws_api_gateway_rest_api.partner_silo_api_gateway.id
  resource_id      = aws_api_gateway_resource.sns_proxy.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

  request_parameters = {
    "method.request.querystring.topic"    = true
    "method.request.querystring.username" = true
  }
}

resource "aws_api_gateway_integration" "sns_proxy_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.partner_silo_api_gateway.id
  resource_id             = aws_api_gateway_resource.sns_proxy.id
  http_method             = aws_api_gateway_method.sns_proxy_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.sns_proxy_lambda.invoke_arn
  request_templates = {
    "application/json" = jsonencode({
      topic    = "$input.params('topic')"
      username = "$input.params('username')"
      body     = "$util.escapeJavascript($input.body)"
    })
  }
}

resource "aws_api_gateway_method_response" "sns_proxy_lambda_response_200" {
  rest_api_id = aws_api_gateway_rest_api.partner_silo_api_gateway.id
  resource_id = aws_api_gateway_resource.sns_proxy.id
  http_method = aws_api_gateway_method.sns_proxy_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "sns_proxy_lambda_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.partner_silo_api_gateway.id
  resource_id = aws_api_gateway_resource.sns_proxy.id
  http_method = aws_api_gateway_method.sns_proxy_method.http_method
  status_code = aws_api_gateway_method_response.sns_proxy_lambda_response_200.status_code
  # Pass through the Lambda response directly
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_lambda_permission" "partner_silo_api_gateway_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sns_proxy_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.partner_silo_api_gateway.execution_arn}/*/${aws_api_gateway_method.sns_proxy_method.http_method}/${aws_api_gateway_resource.sns_proxy.path_part}"
}

resource "aws_api_gateway_deployment" "partner_silo_api_gateway_deployment" {
  depends_on = [aws_api_gateway_integration.sns_proxy_lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.partner_silo_api_gateway.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.sns_proxy_method.http_method
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
  description = "Deployed at ${timestamp()}"
}

resource "aws_api_gateway_stage" "partner_silo_api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.partner_silo_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.partner_silo_api_gateway.id
  stage_name    = "master"
}

resource "aws_api_gateway_api_key" "partner_silo_api_key" {
  name        = "partner-silo-api-key"
  description = "API Key for SDVI Partner Silo API"
  enabled     = true
}

resource "aws_api_gateway_usage_plan" "partner_silo_usage_plan" {
  name        = "partner-silo-api-usage-plan"
  description = "Usage plan for SNS Proxy API"
  api_stages {
    api_id = aws_api_gateway_rest_api.partner_silo_api_gateway.id
    stage  = aws_api_gateway_stage.partner_silo_api_gateway_stage.stage_name
  }
  quota_settings {
    limit  = 1000
    period = "MONTH"
  }
  throttle_settings {
    burst_limit = 20
    rate_limit  = 10
  }
  depends_on = [aws_api_gateway_stage.partner_silo_api_gateway_stage]
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.partner_silo_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.partner_silo_usage_plan.id
}

output "sns_proxy_api_url" {
  value = "${aws_api_gateway_deployment.partner_silo_api_gateway_deployment.invoke_url}${aws_api_gateway_stage.partner_silo_api_gateway_stage.stage_name}/${aws_api_gateway_resource.sns_proxy.path_part}"
}

output "api_key" {
  value     = aws_api_gateway_api_key.partner_silo_api_key.value
  sensitive = true
}
