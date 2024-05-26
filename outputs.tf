output "ec2_instance_ip" {
  description = "Public IP of the EC2 instance"
  value = aws_instance.resume-app-ec2-instance.public_ip
}

output "dns_records" {
  description = "DNS records"
  value = {
    www  = aws_route53_record.www.fqdn
    root = aws_route53_record.root.fqdn
  }
}

output "acm_certificate_arn" {
  description = "ACM certificate ARN"
  value = aws_acm_certificate.resume-app-cert.arn
}
