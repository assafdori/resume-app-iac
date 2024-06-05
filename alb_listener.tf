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

resource "aws_lb_listener" "resume-app-redirect-listener" {
  load_balancer_arn = aws_lb.resume-app-application-load-balancer.arn
  port              = 80  # Port 80 for HTTP traffic
  protocol          = "HTTP"
  
  default_action {
    type             = "redirect"
    redirect {
      port           = "443"  # Redirect to port 443 for HTTPS
      protocol       = "HTTPS"
      status_code    = "HTTP_301"  # Permanent redirect
    }
  }
}


resource "aws_lb_listener" "node-exporter-listener" {
  load_balancer_arn = aws_lb.resume-app-application-load-balancer.arn
  port              = 9100
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node-exporter-target-group.arn  # Node Exporter target group ARN
  }
}

resource "aws_lb_listener" "prometheus-listener" {
  load_balancer_arn = aws_lb.resume-app-application-load-balancer.arn
  port              = 9090
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prometheus-target-group.arn  # Prometheus target group ARN
  }
}

resource "aws_lb_listener" "grafana-listener" {
  load_balancer_arn = aws_lb.resume-app-application-load-balancer.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana-target-group.arn  # Grafana target group ARN
  }
}

resource "aws_lb_listener" "alertmanager-listener" {
  load_balancer_arn = aws_lb.resume-app-application-load-balancer.arn
  port              = 9093
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alertmanager-target-group.arn  # Alertmanger target group ARN
  }
}

