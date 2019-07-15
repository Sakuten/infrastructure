resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = "${tls_private_key.private_key.private_key_pem}"
  email_address   = "${var.acme_email}"
}

resource "acme_certificate" "certificate" {
  account_key_pem           = "${acme_registration.reg.account_key_pem}"
  common_name               = "api.${var.domain}"
  subject_alternative_names = []

  dns_challenge {
    provider = "route53"

    config {
      AWS_ACCESS_KEY_ID     = "${var.aws_access_key}"
      AWS_SECRET_ACCESS_KEY = "${var.aws_secret_key}"
      AWS_DEFAULT_REGION    = "${var.aws_region}"
    }
  }
}

resource "aws_iam_server_certificate" "elb_cert" {
  name_prefix       = "tf-${var.base_name}-cert-"
  certificate_body  = "${acme_certificate.certificate.certificate_pem}"
  private_key       = "${acme_certificate.certificate.private_key_pem}"

  lifecycle {
    create_before_destroy = true
  }
}

