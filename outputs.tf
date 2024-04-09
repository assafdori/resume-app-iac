output "ec2_instance_ip" {
  value = aws_instance.resume-app-ec2-instance.public_ip
}