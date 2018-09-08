resource "aws_ecs_cluster" "main" {
  name = "terraform_ecs_cluster"
}

data "template_file" "task_definition" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    image_url        = "sakuten/backend:latest"
    container_name   = "sakuten_backend"
    log_group_region = "${var.aws_region}"
    log_group_name   = "${aws_cloudwatch_log_group.app.name}"
    secret_key = "${var.secret_key}"
    container_port = "${var.container_port}"
    host_port = "${var.alb_container_port}"
    recaptcha_secret_key = "${var.recaptcha_secret_key}"
    database_url = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.db.endpoint}/postgres"
  }
}

resource "aws_ecs_task_definition" "backend" {
  family                = "tf_backend_td"
  container_definitions = "${data.template_file.task_definition.rendered}"
}

resource "aws_ecs_service" "main" {
  name            = "tf-${var.base_name}-ecs"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.backend.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_service.name}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.main.id}"
    container_name   = "sakuten_backend"
    container_port   = "${var.container_port}"
  }

  depends_on = [
    "aws_iam_role_policy.ecs_service",
    "aws_alb_listener.front_end",
  ]
}

