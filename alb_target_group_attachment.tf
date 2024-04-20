resource "aws_lb_target_group_attachment" "resume-app-attach-target-to-ec2" {
  target_group_arn = aws_lb_target_group.resume-app-application-load-balancer-target-group.arn
  target_id        = aws_instance.resume-app-ec2-instance.id
  port             = 80
}


resource "aws_lb_target_group_attachment" "node-exporter-attach-target-to-ec2" {
  target_group_arn = aws_lb_target_group.node-exporter-target-group.arn  # Use the Node Exporter target group ARN
  target_id        = aws_instance.resume-app-ec2-instance.id  # ID of the EC2 instance
  port             = 9100  # Port on which Node Exporter serves metrics
}

resource "aws_lb_target_group_attachment" "prometheus-attach-target-to-ec2" {
  target_group_arn = aws_lb_target_group.prometheus-target-group.arn  # Use the Node Exporter target group ARN
  target_id        = aws_instance.resume-app-ec2-instance.id  # ID of the EC2 instance
  port             = 9100  # Port on which Node Exporter serves metrics
}

resource "aws_lb_target_group_attachment" "grafana-attach-target-to-ec2" {
  target_group_arn = aws_lb_target_group.grafana-target-group.arn  # Use the Node Exporter target group ARN
  target_id        = aws_instance.resume-app-ec2-instance.id  # ID of the EC2 instance
  port             = 9100  # Port on which Node Exporter serves metrics
}

resource "aws_lb_target_group_attachment" "alertmanager-attach-target-to-ec2" {
  target_group_arn = aws_lb_target_group.alertmanager-target-group.arn  # Use the Node Exporter target group ARN
  target_id        = aws_instance.resume-app-ec2-instance.id  # ID of the EC2 instance
  port             = 9100  # Port on which Node Exporter serves metrics
}
