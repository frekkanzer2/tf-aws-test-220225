resource "aws_route_table" "aws-test-sab-pub-rt" {
  vpc_id = aws_vpc.aws-test-sab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-test-sab-igw.id
  }

  tags = {
    Name = "aws-test-sab-pub-rt",
    Owner = var.owner
  }
}

resource "aws_route_table" "aws-test-sab-pri-rt" {
  vpc_id = aws_vpc.aws-test-sab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.aws-test-sab-ngw.id
  }

  tags = {
    Name = "aws-test-sab-pri-rt",
    Owner = var.owner
  }
}

resource "aws_route_table_association" "aws-test-sab-pub-rt-ass" {
  subnet_id      = aws_subnet.aws-test-sab-pub.id
  route_table_id = aws_route_table.aws-test-sab-pub-rt.id
}
resource "aws_route_table_association" "aws-test-sab-pri-rt-ass" {
  subnet_id      = aws_subnet.aws-test-sab-pri.id
  route_table_id = aws_route_table.aws-test-sab-pri-rt.id
}