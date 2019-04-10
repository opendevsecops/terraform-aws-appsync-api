data "aws_region" "current" {}

# ---

resource "aws_appsync_graphql_api" "main" {
  name                = "${var.name}"
  authentication_type = "${var.authentication_type}"

  schema = "${var.schema}"
}

# ---

data "aws_lambda_invocation" "endpoint" {
  function_name = "helperGetGraphqlApi"

  input = <<JSON
{
	"apiId": "${aws_appsync_graphql_api.main.id}"
}
JSON
}

# ---

