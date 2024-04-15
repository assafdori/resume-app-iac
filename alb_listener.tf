# Create a listener on port 443 for HTTPS traffic
resource "aws_lb_listener" "resume-app-application-load-balancer-listener" {
  load_balancer_arn = aws_lb.resume-app-application-load-balancer.arn
  port              = 443
  protocol          = "HTTPS"
  
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.resume-app-cert.arn
  
  default_action {
    target_group_arn = aws_lb_target_group.resume-app-application-load-balancer-target-group.arn
    type             = "forward"
  }

  depends_on = [aws_acm_certificate_validation.resume-app-cert]
}