locals {
  common-tags = {
    Owner                 = var.owner
    DateOfDecommission    = formatdate("YYYY-MM-DD", timeadd(timestamp(), "1209600s"))
    Schedule              = var.ec2-schedule-type
  }
}

resource "aws_launch_template" "ec2-template-database" {
  name_prefix   = "ci-database-"
  image_id      = "ami-077e2fabf29e9a90b"
  instance_type = "t3.micro"
  key_name      = var.ec2-access-keys

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.sg_database.id]
    subnet_id                   = aws_subnet.aws-test-sab-pri-database-1.id
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common-tags, { Name = "ci-database" })
  }

  tag_specifications {
    resource_type = "volume"
    tags          = merge(local.common-tags, { Name = "ci-database" })
  }

  user_data = filebase64("ec2_userdata/ec2_postgres.bash")

  instance_initiated_shutdown_behavior = "terminate"
}

resource "aws_launch_template" "ec2-template-server" {
  name_prefix   = "ci-server-"
  image_id      = "ami-077e2fabf29e9a90b"
  instance_type = "t3.micro"
  key_name      = var.ec2-access-keys

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.sg_app-server.id]
    subnet_id                   = aws_subnet.aws-test-sab-pri-server-1.id
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common-tags, { Name = "ci-server" })
  }

  tag_specifications {
    resource_type = "volume"
    tags          = merge(local.common-tags, { Name = "ci-server" })
  }

  user_data = base64encode(templatefile("ec2_userdata/ec2_server.bash.tpl", {
    IP_EC2_DB = aws_instance.database_instance.private_ip
  }))

  instance_initiated_shutdown_behavior = "terminate"
}