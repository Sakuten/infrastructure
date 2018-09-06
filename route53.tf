resource "aws_route53_zone" "api_sakuten_jp" {
  name = "${var.domain}"
}

resource "aws_route53_record" "api" {
  zone_id = "${aws_route53_zone.api_sakuten_jp.zone_id}"
  name = "${var.api_subdomain}.${var.domain}"
  type = "A"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}
