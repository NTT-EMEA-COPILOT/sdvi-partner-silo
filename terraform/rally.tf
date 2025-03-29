module "rally_resources" {
  for_each = toset(var.partner_silo_config.user_names)
  source        = "./modules/rally_resource"
  user_name     = each.key
  rally_api_key = var.partner_silo_info.api_token
}