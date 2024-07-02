resource "aws_instance" "resume-app-ec2-instance" {
  ami             = var.aws_ami # This is a custom AMI. ARM platform with Docker pre-installed.
  instance_type   = var.aws_instance_type
  vpc_security_group_ids = [aws_security_group.resume-app-security-group.id]
  subnet_id       = aws_subnet.resume-app-public-subnet.id
  key_name        = var.aws_key_pair

  tags = {
    Name = "${var.environment}-${var.instance_name}"
  }
}
