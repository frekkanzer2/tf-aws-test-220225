resource "aws_security_group" "sg_database" {
  name        = "sg_database"
  description = "Security Group for PostgreSQL database"
  vpc_id      = aws_vpc.aws-test-sab.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_app-server.id, aws_security_group.sg_app-server-direct.id]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    security_groups = [aws_security_group.sg_app-server.id, aws_security_group.sg_app-server-direct.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "sg_database"
    Owner = "fr.abate@reply.it"
  }
}

resource "aws_security_group" "sg_app-server" {
  name        = "sg_app-server"
  description = "Security group for Application Server"
  vpc_id      = aws_vpc.aws-test-sab.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_alb-server.id]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_alb-server.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_app-server",
    Owner = var.owner
  }
}

resource "aws_security_group" "sg_app-server-direct" {
  name        = "sg_app-server-direct"
  description = "Security group for Application Server with EC2 Instance Connect support"
  vpc_id      = aws_vpc.aws-test-sab.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_app-server-direct",
    Owner = var.owner
  }
}

resource "aws_security_group" "sg_alb-server" {
  name        = "sg_alb-server"
  description = "Security Group for ALB that managed IC application servers"
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

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = [aws_vpc.aws-test-sab.cidr_block]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = [aws_vpc.aws-test-sab.cidr_block]
  }

  tags = {
    Name  = "sg_alb-server"
    Owner = "fr.abate@reply.it"
  }
}
