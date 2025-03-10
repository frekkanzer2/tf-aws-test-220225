resource "aws_autoscaling_group" "asg-app-server" {
  name                 = "asg-app-server"
  min_size             = 1
  desired_capacity     = 2
  max_size             = 5
  vpc_zone_identifier  = [aws_subnet.aws-test-sab-pri-server-1.id]
  
  launch_template {
    id      = aws_launch_template.ec2-template-server.id
    version = "$Latest"
  }

  health_check_type          = "EC2"
  health_check_grace_period  = 300
  wait_for_capacity_timeout   = "5m"
  force_delete               = true
  target_group_arns = [
    aws_lb_target_group.app-server-lb-tg.arn
  ]

  tag {
    key                 = "Owner"
    value               = var.owner
    propagate_at_launch = false
  }
}