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

resource "aws_security_group" "sg_direct-app-server" {
  name        = "direct-app-server"
  description = "Security group for EC2 with IC server"
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

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Consente tutto il traffico in uscita
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_direct-app-server",
    Owner = var.owner
  }
}