resource "aws_lb" "app-server-lb" {
  name               = "app-server-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.aws-test-sab-pub-1.id, aws_subnet.aws-test-sab-pub-2.id]

  enable_deletion_protection = false

  tags = {
    Name = "app-server-lb",
    Owner = var.owner
  }
}