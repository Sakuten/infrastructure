resource "aws_route53_zone" "sakuten" {
   name = "${var.domain}"
}

resource "aws_route53_record" "root" {
   zone_id = "${aws_route53_zone.sakuten.zone_id}"
   name = "${var.domain}"
   type = "A"
   ttl = "300"
   records = ["104.198.14.52"]  // Netlify's load balancer
}

resource "aws_route53_record" "www" {
   zone_id = "${aws_route53_zone.sakuten.zone_id}"
   name = "www.${var.domain}"
   type = "CNAME"
   ttl = "300"
   records = ["sakuten-deployment.netlify.com"]
}

resource "aws_route53_record" "api" {
   zone_id = "${aws_route53_zone.sakuten.zone_id}"
   name = "api.${var.domain}"
   type = "A"

   alias {
     name                   = "${aws_elb.main.dns_name}"
     zone_id                = "${aws_elb.main.zone_id}"
     evaluate_target_health = true
   }
}
