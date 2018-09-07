resource "aws_elb" "elb" {
  connection_draining = true
  connection_draining_timeout = 300
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80${var.elb_health_check_endpoint}"
    timeout = 3
    unhealthy_threshold = 2
  }
  idle_timeout = 300
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  name = "${var.name}-elb"
  subnets = ["${aws_subnet.public3.id}", "${aws_subnet.public4.id}"]
  security_groups = ["${aws_security_group.internal.id}", "${aws_security_group.lb.id}"]
  tags {
    Name = "${var.name}_elb"
  }
}
