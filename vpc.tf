resource "aws_vpc" "aws-test-sab" {
  cidr_block       = "10.1.0.0/25"
  instance_tenancy = "default"

  tags = {
    Name = "aws-test-sab",
    Owner = var.owner
  }
}