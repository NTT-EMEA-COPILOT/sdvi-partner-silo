aws_provider_info = {
  region = "eu-west-1"
}

project_info = {
  name = "sdvi-partner-silo"
  env  = "dev"
}

partner_silo_info = {
  bucket_name                     = "sdvi-partner-silo-storage"
  abort_multipart_expiration_days = 10
  default_expiration_days         = 30
  sdvi_managed_account            = 916935837113
  sdvi_external_id                = "63284dac-554a-4a7a-8578-fe7c27aca74d"
}

partner_silo_config = {
  user_names = [
    "test_user",
    "stefano_barbareschi",
    "andrea_marasco",
    "rebecca_morda",
    "jeanfelipe_fonseca"
  ]
}
