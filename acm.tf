resource "aws_acm_certificate" "resume-app-cert" {
  domain_name       = var.wildcard_domain_name
  validation_method = "DNS"

  subject_alternative_names = [var.domain_name]

  tags = {
    Name = var.aws_certificate_name
  }
}

resource "aws_acm_certificate_validation" "resume-app-cert" {
  certificate_arn         = aws_acm_certificate.resume-app-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cname-validation : record.fqdn]
}
