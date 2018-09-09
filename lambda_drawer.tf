resource "aws_cloudwatch_event_rule" "tp" {
  count               = 4
  name                = "tf-${var.base_name}-tp${count.index}-event"
  schedule_expression = "${element(var.tps, count.index)}"
}

resource "aws_cloudwatch_event_target" "tp_target" {
  count     = 4
  rule      = "${element(aws_cloudwatch_event_rule.tp.*.name, count.index)}"
  arn       = "${aws_lambda_function.drawer.arn}"
}

resource "aws_lambda_permission" "allow_call_tp" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.drawer.function_name}"
  principal     = "events.amazonaws.com"
}

data "archive_file" "drawer_archive" {
  type        = "zip"
  source_dir  = "${var.drawer_source_path}"
  output_path = "${var.drawer_archive_path}"
}

resource "aws_lambda_function" "drawer" {
  filename         = "${var.drawer_archive_path}"
  function_name    = "draw_lotteries"
  role             = "${aws_iam_role.lambda_iam.arn}"
  handler          = "draw.draw"
  source_code_hash = "${data.archive_file.drawer_archive.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = 10

  environment {
    variables = {
      ADMIN_SECRET_ID = "${var.admin_secret_id}"
    }
  }
}
