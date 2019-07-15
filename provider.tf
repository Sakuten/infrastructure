provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"

  version = "~> 2.7.0"
}

provider "acme" {
  server_url = "${var.acme_server_url}"

  version = "~> 1.2.0"
}

provider "archive" {
  version = "~> 1.2.0"
}

provider "template" {
  version = "~> 2.1.0"
}

provider "tls" {
  version = "~> 2.0.0"
}