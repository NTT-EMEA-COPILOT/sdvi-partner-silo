resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "../scripts/rally_api.sh"
    environment = {
      API_KEY  = var.rally_api_key
      API_PATH = "tagNames"
      REQ_BODY = "{\"data\": {\"type\": \"tagNames\",\"attributes\":{\"name\": \"${var.user_name}\",\"curated\": true}}}"
    }
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}
