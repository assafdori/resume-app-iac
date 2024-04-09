provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.resume-app-ec2-instance.public_ip]
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = "300"
  records = [aws_instance.resume-app-ec2-instance.public_ip]
}

output "dns_records" {
  description = "DNS records created"
  value = {
    www = aws_route53_record.www.fqdn
    root = aws_route53_record.root.fqdn
  }
}
