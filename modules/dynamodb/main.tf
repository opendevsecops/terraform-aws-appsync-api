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
			"Action": "*",
			"Resource": [
				"arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.table}",
				"arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.table}/*"
			]
		}
	]
}
EOF
}

# ---

resource "aws_appsync_datasource" "dynamodb_table" {
  api_id = "${var.api}"
  name   = "${var.name}"
  type   = "AMAZON_DYNAMODB"

  dynamodb_config {
    region     = "${data.aws_region.current.name}"
    table_name = "${var.table}"
  }

  service_role_arn = "${aws_iam_role.service_role.arn}"
}

# ---

