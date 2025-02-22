resource "aws_nat_gateway" "aws-test-sab-ngw" {
  allocation_id = aws_eip.aws-test-sab-eip-pri.id
  subnet_id     = aws_subnet.aws-test-sab-pub.id

  tags = {
    Name = "aws-test-sab-ngw",
    Owner = var.owner
  }
}