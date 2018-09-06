resource "aws_iam_role_policy" "ecs_instance" {
  name = "${var.name}_ecs_instance_policy"
  policy = "${file("ecs_cluster_instance.json")}"
  role = "${aws_iam_role.ecs_service.id}"
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = "${var.name}_ecs_instance_profile"
  path = "/"
  role = "${aws_iam_role.ecs_service.name}"
}

resource "aws_key_pair" "key_pair" {
  key_name = "${var.name}"
  public_key = "${var.ssh_public_key}"
}

resource "aws_instance" "app" {
  ami = "${var.ec2_ami}"
  associate_public_ip_address = "false"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance.id}"
  instance_type = "${var.ec2_instance_type}"
  key_name = "${var.name}"
  root_block_device = {
    volume_size = "${var.ec2_gp2_size}"
    volume_type = "gp2"
  }
  subnet_id = "${aws_subnet.private1.id}"
  tags {
    Name = "${var.name}_app"
  }
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
}
