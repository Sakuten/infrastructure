resource "aws_db_subnet_group" "main" {
  name        = "db_subnet"
  subnet_ids  = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}"]
  tags {
      Name = "db_subnet"
  }
}

resource "aws_db_parameter_group" "default" {
  name = "rds-pg"
  family = "postgres10.4"
  description = "Managed by Terraform"

  parameter {
    name = "time_zone"
    value = "Asia/Tokyo"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_instance" "db" {
  identifier              = "database"
  allocated_storage       = 5
  engine                  = "postgres"
  engine_version          = "10.4"
  instance_class          = "db.m4.large"
  storage_type            = "gp2"
  username                = "***"
  password                = "***"
  backup_retention_period = 7
  vpc_security_group_ids  = ["${aws_security_group.db.id}"]
  db_subnet_group_name    = "${aws_db_subnet_group.main.name}"
}

