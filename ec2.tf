resource "aws_instance" "database_instance" {
  launch_template {
    id      = aws_launch_template.ec2-template-database.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}