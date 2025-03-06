module "sns_user_topic_1" {
  for_each = toset(var.partner_silo_config.user_names)
  source               = "./modules/sns_user_topic"
  topic_name           = "topic_1_${each.key}"
  sdvi_managed_account = var.partner_silo_info.sdvi_managed_account
  project_info         = var.project_info
}

module "sns_user_topics_2" {
  for_each = toset(var.partner_silo_config.user_names)
  source               = "./modules/sns_user_topic"
  topic_name           = "topic_2_${each.key}"
  sdvi_managed_account = var.partner_silo_info.sdvi_managed_account
  project_info         = var.project_info
}
