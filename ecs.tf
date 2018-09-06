resource "aws_ecs_cluster" "main" {
  name = "${var.name}"
}

resource "aws_ecs_task_definition" "backend" {
  family = "${var.name}_backend"
  container_definitions = "${file("ecs_service.json")}"
}
