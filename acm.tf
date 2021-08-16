resource "aws_acm_certificate" "cert" {
  domain_name       = "1fin-science.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "zone" {
  name         = "1fin-science.com"
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name    = "${tolist(aws_acm_certificate.cert.domain_validation_options).0.resource_record_name}"
  type    = "${tolist(aws_acm_certificate.cert.domain_validation_options).0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.id}"
  records = ["${tolist(aws_acm_certificate.cert.domain_validation_options).0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}
