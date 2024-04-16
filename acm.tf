resource "aws_acm_certificate" "resume-app-cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "resume-app-ssl-cert"
  }
}

resource "aws_acm_certificate_validation" "resume-app-cert" {
  certificate_arn         = aws_acm_certificate.resume-app-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}