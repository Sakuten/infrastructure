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

resource "aws_lambda_permission" "allow_call" {
  count         = 4
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.drawer.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${element(aws_cloudwatch_event_rule.tp.*.arn, count.index)}"
}

