resource "aws_cloudwatch_event_rule" "dbgen" {
  name                = "tf-${var.base_name}-dbgen-event"
  schedule_expression = "${var.dbgen_schedule}"
}

resource "aws_cloudwatch_event_target" "dbgen_taget" {
  rule      = "${aws_cloudwatch_event_rule.dbgen.name}"
  arn       = "${aws_lambda_function.gen_db.arn}"
}

resource "aws_lambda_permission" "allow_call" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.gen_db.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.dbgen.arn}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "tf-${var.base_name}-bucket"
  acl    = "private"
}

resource "aws_s3_bucket_object" "lambda_function_archive" {
  bucket = "${aws_s3_bucket.bucket.id}"
  key    = "lambda_function_archive"
  source = "dbgen/function.zip"
  etag = "${md5(file("dbgen/function.zip"))}"
}

resource "aws_lambda_function" "gen_db" {
  s3_bucket        = "${aws_s3_bucket.bucket.id}"
  s3_key           = "lambda_function_archive"
  function_name    = "generate_initial_db"
  role             = "${aws_iam_role.lambda_iam.arn}"
  handler          = "app.gen"
  source_code_hash = "${base64sha256(file("dbgen/function.zip"))}"
  runtime          = "python3.6"
  memory_size      = 512
  timeout          = 10

  vpc_config {
    subnet_ids = ["${aws_subnet.main.*.id}"]
    security_group_ids = ["${aws_security_group.lambda_sg.id}"]
  }

  environment {
    variables = {
      DATABASE_URL = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.db.endpoint}/postgres"
    }
  }

  depends_on = ["aws_iam_role_policy_attachment.lamba_exec_role_eni", "aws_s3_bucket_object.lambda_function_archive"]
}
