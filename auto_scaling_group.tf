resource "aws_iam_instance_profile" "ecs" {
    name = "ecs-instance-profile"
    path = "/"
    role = "${aws_iam_role.ecs_service.name}"
}

resource "aws_key_pair" "instance" {
  public_key = "${var.ssh_public_key}"
}

resource "aws_launch_configuration" "app" {
    name = "${var.name}_launch_config"
    image_id = "${var.ec2_ami}"
    instance_type = "${var.ec2_instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
    key_name = "${aws_key_pair.instance.key_name}"
    security_groups = ["${aws_security_group.instance.id}"]
    associate_public_ip_address = false
    user_data = "${file("api-ecs.sh")}"
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "app" {
    name = "${var.name}_asg"
    max_size = 4
    min_size = 1
    health_check_grace_period = 300
    health_check_type = "ELB"
    desired_capacity = 1
    force_delete = true
    launch_configuration = "${aws_launch_configuration.app.id}"
    vpc_zone_identifier = ["${aws_subnet.private1.id}"]
    load_balancers = ["${aws_elb.elb.name}"]
}

