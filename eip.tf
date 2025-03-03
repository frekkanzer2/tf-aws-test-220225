resource "aws_eip" "aws-test-sab-eip-pri" {
  tags = {
    Owner = var.owner
  }
}

resource "aws_eip" "aws-test-sab-eip-template-ec2" {
  tags = {
    Owner = var.owner
  }
}