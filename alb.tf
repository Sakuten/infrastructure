resource "aws_alb_target_group" "main" {
  name     = "tf-${var.base_name}-ecs"
  port     = "${var.alb_container_port}"
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"

  health_check {
    path = "${var.health_check_path}"
  }
}

resource "aws_alb" "main" {
  name            = "tf-${var.base_name}-alb-ecs"
  subnets         = ["${aws_subnet.main.*.id}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${aws_iam_server_certificate.elb_cert.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.main.id}"
    type             = "forward"
  }
}

