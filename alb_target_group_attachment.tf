resource "aws_lb_target_group_attachment" "resume-app-attach-target-to-ec2" {
  target_group_arn = aws_lb_target_group.resume-app-application-load-balancer-target-group.arn
  target_id        = aws_instance.resume-app-ec2-instance.id
  port             = 80
}
