resource "aws_alb_target_group" "main" {
  name     = "tf-${var.base_name}-ecs"
  port     = "${var.alb_container_port}"
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

resource "aws_alb" "main" {
  name            = "tf-${var.base_name}-alb-ecs"
  subnets         = ["${aws_subnet.main.*.id}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.main.id}"
    type             = "forward"
  }
}

