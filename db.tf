resource "aws_db_subnet_group" "main" {
  name        = "db_subnet"
  subnet_ids  = ["${aws_subnet.main.*.id}"]
  tags {
      Name = "db_subnet"
  }
}

resource "aws_db_parameter_group" "db_pg" {
  name = "rds-pg"
  family = "postgres10"
  description = "Managed by Terraform"

  parameter {
    name = "timezone"
    value = "Asia/Tokyo"
  }
}

resource "aws_db_instance" "db" {
  identifier              = "database"
  allocated_storage       = 5
  engine                  = "postgres"
  engine_version          = "10.4"
  instance_class          = "${var.db_instance_type}"
  storage_type            = "gp2"
  username                = "${var.db_username}"
  password                = "${var.db_password}"
  backup_retention_period = 7
  vpc_security_group_ids  = ["${aws_security_group.db.id}"]
  db_subnet_group_name    = "${aws_db_subnet_group.main.name}"
  parameter_group_name = "${aws_db_parameter_group.db_pg.name}"
}

