resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "gen_db" {
  filename         = "dbgen/function.zip"
  function_name    = "generate_initial_db"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "app.gen"
  source_code_hash = "${base64sha256(file("dbgen/function.zip"))}"
  runtime          = "python3.6"

  environment {
    variables = {
      DATABASE_URL = "${postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.db.endpoint}/postgres}"
    }
  }
}
