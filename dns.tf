resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
 // ttl     = "300"
 // records = [aws_lb.resume-app-application-load-balancer.dns_name]
  depends_on = [aws_lb.resume-app-application-load-balancer]

    alias {
    name                   = aws_lb.resume-app-application-load-balancer.dns_name
    zone_id                = aws_lb.resume-app-application-load-balancer.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
 // ttl     = "300"
 // records = [aws_lb.resume-app-application-load-balancer.dns_name]
  depends_on = [aws_lb.resume-app-application-load-balancer]

    alias {
    name                   = aws_lb.resume-app-application-load-balancer.dns_name
    zone_id                = aws_lb.resume-app-application-load-balancer.zone_id
    evaluate_target_health = true
  }

}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.resume-app-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}
