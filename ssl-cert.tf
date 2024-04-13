resource "aws_acm_certificate" "resume-app-cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "resume-app-ssl-cert"
  }
}
