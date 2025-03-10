resource "aws_lb" "app-server-lb" {
  name               = "app-server-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb-server.id]
  subnets            = [aws_subnet.aws-test-sab-pub-1.id, aws_subnet.aws-test-sab-pub-2.id]

  enable_deletion_protection = false
  drop_invalid_header_fields = true
  idle_timeout = 30

  tags = {
    Name = "app-server-lb",
    Owner = var.owner
  }
}

resource "aws_lb_listener" "app-server-lb-http" {
  load_balancer_arn = aws_lb.app-server-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-server-lb-tg.arn
  }
}

resource "aws_lb_target_group" "app-server-lb-tg" {
  name     = "app-server-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.aws-test-sab.id

  health_check {
    protocol = "HTTP"
    path     = "/status"
    interval = 30
    timeout  = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}