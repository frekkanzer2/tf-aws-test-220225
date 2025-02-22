resource "aws_eip" "aws-test-sab-eip-pri" {
  tags = {
    Owner = var.owner
  }
}