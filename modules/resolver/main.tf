resource "aws_appsync_resolver" "main" {
  api_id = "${var.api}"
  type   = "${var.type}"
  field  = "${var.field}"

  data_source = "${var.data_source}"

  request_template  = "${var.request_template}"
  response_template = "${var.response_template}"
}

# ---

