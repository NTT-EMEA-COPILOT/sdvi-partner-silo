module "sns_user_folders" {
  for_each = toset(var.partner_silo_config.user_names)
  source                                     = "./modules/s3_user_folders"
  user_name                                  = each.key
  partner_silo_bucket_id                     = aws_s3_bucket.partner_silo_bucket.id
  abort_multipart_expiration_days            = var.partner_silo_info.abort_multipart_expiration_days
  default_expiration_days                    = var.partner_silo_info.default_expiration_days
}