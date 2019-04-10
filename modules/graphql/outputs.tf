output "id" {
  value = "${aws_appsync_graphql_api.main.id}"
}

output "arn" {
  value = "${aws_appsync_graphql_api.main.arn}"
}

# ---

output "url" {
  value = "${data.aws_lambda_invocation.endpoint.result_map["uri"]}"
}

# ---

