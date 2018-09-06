resource "aws_ecs_cluster" "main" {
  name = "${var.name}"
}

data "template_file" "ecs_service" {
  template = "${file("ecs_service.json")}"

  vars {
    secret_key = "${var.secret_key}"
    recaptcha_secret_key = "${var.recaptcha_secret_key}"
    database_url = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.db.endpoint}/postgres"
  }
}

resource "aws_ecs_task_definition" "backend" {
  family = "${var.name}_backend"
  container_definitions = "${data.template_file.ecs_service.rendered}"
}
