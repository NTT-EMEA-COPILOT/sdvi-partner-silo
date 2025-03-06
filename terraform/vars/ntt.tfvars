aws_provider_info = {
  region = "eu-south-1"
}

project_info = {
  name = "sdvi-partner-silo"
  env  = "dev"
}

partner_silo_info = {
  bucket_name                     = "sdvi-partner-silo-storage"
  abort_multipart_expiration_days = 15
  default_expiration_days         = 60
  sdvi_managed_account            = 916935837113
  sdvi_external_id                = "63284dac-554a-4a7a-8578-fe7c27aca74d"
}

partner_silo_config = {
  user_names = [
    "roberto_corno"
  ]
}
