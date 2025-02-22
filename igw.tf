resource "aws_internet_gateway" "aws-test-sab-igw" {
  vpc_id = aws_vpc.aws-test-sab.id

  tags = {
    Name = "aws-test-sab-igw",
    Owner = var.owner
  }
}