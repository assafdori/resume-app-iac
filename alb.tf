resource "aws_lb" "resume-app-application-load-balancer" {
  name               = var.resume-app-application-load-balancer-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.resume-app-security-group.id]
  subnets            = [aws_subnet.resume-app-public-subnet.id, aws_subnet.resume-app-public-subnet2.id] # 2 subnets minimum

  depends_on = [aws_acm_certificate_validation.resume-app-cert]
}
