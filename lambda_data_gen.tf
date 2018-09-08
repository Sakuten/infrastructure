data "external" "virtualenv_path" {
  program = ["bash", "virtualenv_path.sh"]
}


data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "dbgen/"
  output_path = "dbgen/function.zip"
}

data "archive_file" "lambda_archive_deps" {
  type        = "zip"
  source_dir  = "${data.external.virtualenv_path.result["path"]}/lib/python3.6/site-packages"
  output_path = "dbgen/function.zip"
}
