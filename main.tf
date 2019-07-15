data "aws_availability_zones" "available" {
}

## CloudWatch Logs

resource "aws_cloudwatch_log_group" "ecs" {
  name = "tf-${var.base_name}-ecs-group/ecs-agent"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "tf-${var.base_name}-ecs-group/app-backend"
}

