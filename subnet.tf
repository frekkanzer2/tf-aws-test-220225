resource "aws_subnet" "aws-test-sab-pub" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.0/27"

  tags = {
    Name = "aws-test-sab-pub",
    Owner = var.owner
  }
}

resource "aws_subnet" "aws-test-sab-pri-server" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.32/28"

  tags = {
    Name = "aws-test-sab-pri-server",
    Owner = var.owner
  }
}

resource "aws_subnet" "aws-test-sab-pri-database" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.48/28"

  tags = {
    Name = "aws-test-sab-pri-database",
    Owner = var.owner
  }
}