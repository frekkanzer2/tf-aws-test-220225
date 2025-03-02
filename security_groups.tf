resource "aws_security_group" "sg_app-server-lb" {
  name        = "app-server-lb"
  description = "Security group for Application Server Load Balancer"
  vpc_id      = aws_vpc.aws-test-sab.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_app-server-lb",
    Owner = var.owner
  }
}