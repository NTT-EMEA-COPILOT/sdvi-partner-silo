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
}

partner_silo_config = {
  user_names = [
    "rebecca_morda",
    "stefano_barbareschi"
  ]
}
