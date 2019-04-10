data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# ---

resource "aws_iam_role" "service_role" {
  name = "${var.name}AppSyncServiceRole"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "appsync.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "service_role_policy" {
  name = "policy"
  role = "${aws_iam_role.service_role.name}"

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": "lambda:invokeFunction",
			"Resource": [
				"${var.lambda}",
				"${var.lambda}:*"
			]
		}
	]
}
EOF
}

# ---

resource "aws_appsync_datasource" "lambda_function" {
  api_id = "${var.api}"
  name   = "${var.name}"
  type   = "AWS_LAMBDA"

  lambda_config {
    function_arn = "${var.lambda}"
  }

  service_role_arn = "${aws_iam_role.service_role.arn}"
}

# ---

