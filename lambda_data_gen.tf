
data "template_file" "lambda_config_cfg" {
  template = "${file("${path.module}/dbgen/config.tpl.cfg")}"

  vars {
    database_url = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.db.endpoint}/postgres"
    ids_json_path = "../ids.json"
  }
}
