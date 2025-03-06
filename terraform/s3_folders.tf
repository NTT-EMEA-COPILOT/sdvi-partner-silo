module "sns_user_folders" {
  for_each = toset(var.partner_silo_config.user_names)
  source                  = "./modules/s3_user_folders"
  user_name               = each.key
  partner_silo_bucket_id  = aws_s3_bucket.partner_silo_bucket.id
  partner_silo_bucket_arn = aws_s3_bucket.partner_silo_bucket.arn
}