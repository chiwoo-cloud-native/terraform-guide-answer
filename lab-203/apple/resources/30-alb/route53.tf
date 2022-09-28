resource "aws_route53_record" "portal" {
  name            = format("portal.%s", var.domain)
  zone_id         = data.aws_route53_zone.public.zone_id
  type            = "CNAME"
  ttl             = "300"
  records         = [aws_lb.this.dns_name]
  allow_overwrite = true
}
