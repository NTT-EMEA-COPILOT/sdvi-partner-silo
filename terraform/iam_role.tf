resource "aws_iam_role" "partner_silo_role" {
  name               = join("-", [var.project_info["name"], var.project_info["env"], "role"])
  assume_role_policy = data.aws_iam_policy_document.partner_silo_assume_role_policy_doc.json
  tags = {
    Name        = join("-", [var.project_info["name"], var.project_info["env"], "role"])
    Project     = var.project_info["name"]
    Environment = var.project_info["env"]
    Terraform   = "true"
  }
}

output "partner_silo_role_arn" {
  value = aws_iam_role.partner_silo_role.arn
}