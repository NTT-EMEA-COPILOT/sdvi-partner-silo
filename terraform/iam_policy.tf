resource "aws_iam_role_policy" "sdvi_rally" {
  name   = join("-", [var.project_info["name"], var.project_info["env"], "rally-policy"])
  role   = aws_iam_role.partner_silo_role.id
  policy = data.aws_iam_policy_document.partner_silo_policy_doc.json
}
