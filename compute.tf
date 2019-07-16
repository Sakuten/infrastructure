resource "aws_autoscaling_group" "app" {
  name                 = "tf-${var.base_name}-asg"
  vpc_zone_identifier  = aws_subnet.main.*.id
  min_size             = var.asg_min
  max_size             = var.asg_max
  desired_capacity     = var.asg_desired
  launch_configuration = aws_launch_configuration.app.name
}

data "template_file" "cloud_config" {
  template = file("${path.module}/cloud-config.yml")

  vars = {
    aws_region         = var.aws_region
    ecs_cluster_name   = aws_ecs_cluster.main.name
    ecs_log_level      = "info"
    ecs_agent_version  = "latest"
    ecs_log_group_name = aws_cloudwatch_log_group.ecs.name
  }
}

data "aws_ami" "stable_coreos" {
  most_recent = true

  filter {
    name   = "description"
    values = ["CoreOS Container Linux stable *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["595879546273"] # CoreOS
}

resource "aws_key_pair" "instance" {
  public_key = var.ssh_public_key
}

resource "aws_launch_configuration" "app" {
  security_groups = [
    aws_security_group.instance_sg.id,
  ]

  key_name                    = aws_key_pair.instance.key_name
  image_id                    = data.aws_ami.stable_coreos.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.app.name
  user_data                   = data.template_file.cloud_config.rendered
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

