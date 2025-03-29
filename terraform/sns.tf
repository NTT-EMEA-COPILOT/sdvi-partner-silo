module "sns_user_topic_1" {
  for_each = toset(var.partner_silo_config.user_names)
  source               = "./modules/sns_user_topic"
  topic_name           = "${var.project_info.name}-topic-1-${each.key}"
  project_info         = var.project_info
}

module "sns_user_topics_2" {
  for_each = toset(var.partner_silo_config.user_names)
  source               = "./modules/sns_user_topic"
  topic_name           = "${var.project_info.name}-topic-2-${each.key}"
  project_info         = var.project_info
}
