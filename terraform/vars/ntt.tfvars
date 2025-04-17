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
  api_token                       = "xur3GxPon8fKj7ggzhTCcaZ9VATQMw5HteiKUJWjjnpf6wyzo+jf8JMLMGuYOXg0"
}

partner_silo_config = {
  user_names = [
    "test_user",
    "stefano_barbareschi",
    "andrea_marasco",
    "rebecca_morda",
    "jeanfelipe_fonseca",
    "aldo_zavalina",
    "andrea_briganti",
    "francesco_musumanno",
    "mario_rizzo",
    "carlo_desimone"
  ]
}
