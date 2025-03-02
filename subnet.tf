resource "aws_subnet" "aws-test-sab-pub-1" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.0/28"

  tags = {
    Name = "aws-test-sab-pub-1",
    Owner = var.owner
  }
}

resource "aws_subnet" "aws-test-sab-pub-2" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.16/28"

  tags = {
    Name = "aws-test-sab-pub-2",
    Owner = var.owner
  }
}

resource "aws_subnet" "aws-test-sab-pri-server-1" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.32/28"

  tags = {
    Name = "aws-test-sab-pri-server-1",
    Owner = var.owner
  }
}

resource "aws_subnet" "aws-test-sab-pri-server-2" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.48/28"

  tags = {
    Name = "aws-test-sab-pri-server-2",
    Owner = var.owner
  }
}

resource "aws_subnet" "aws-test-sab-pri-database-1" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.64/28"

  tags = {
    Name = "aws-test-sab-pri-database-1",
    Owner = var.owner
  }
}

resource "aws_subnet" "aws-test-sab-pri-database-2" {
  vpc_id     = aws_vpc.aws-test-sab.id
  cidr_block = "10.1.0.80/28"

  tags = {
    Name = "aws-test-sab-pri-database-2",
    Owner = var.owner
  }
}