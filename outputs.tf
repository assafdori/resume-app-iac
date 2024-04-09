output "ec2_instance_ip" {
  value = aws_instance.resume-app-ec2-instance.public_ip
}

output "dns_records" {
  description = "DNS records created"
  value = {
    www = aws_route53_record.www.fqdn
    root = aws_route53_record.root.fqdn
  }
}