resource "aws_appsync_datasource" "none" {
  api_id = "${var.api}"
  name   = "${var.name}"
  type   = "NONE"
}

# ---

