resource "aws_security_group" "lambda_sg" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "tf-${var.base_name}-lambda-sg"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_iam_role" "lambda_iam" {
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

resource "aws_iam_role_policy_attachment" "lamba_exec_role_eni" {
  role = "${aws_iam_role.lambda_iam.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_lambda_function" "gen_db" {
  filename         = "dbgen/function.zip"
  function_name    = "generate_initial_db"
  role             = "${aws_iam_role.lambda_iam.arn}"
  handler          = "app.gen"
  source_code_hash = "${base64sha256(file("dbgen/function.zip"))}"
  runtime          = "python3.6"
  memory_size      = 512

  timeouts {
    create = "5m"
  }

  vpc_config {
    subnet_ids = ["${aws_subnet.main.*.id}"]
    security_group_ids = ["${aws_security_group.lambda_sg.id}"]
  }

  environment {
    variables = {
      DATABASE_URL = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.db.endpoint}/postgres"
    }
  }

  depends_on = ["aws_iam_role_policy_attachment.lamba_exec_role_eni"]
}
