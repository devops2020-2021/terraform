resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.zone.id}"
  name    = "1fin-science.com"
  type    = "A"

  alias {
    name                   = replace(aws_cloudfront_distribution.cf_distribution.domain_name, "/[.]$/", "")
    zone_id                = "${aws_cloudfront_distribution.cf_distribution.hosted_zone_id}"
    evaluate_target_health = true
  }

  depends_on = [aws_cloudfront_distribution.cf_distribution]
}
