resource "aws_launch_template" "ec2-template-database" {
  name_prefix   = "ci-database-"
  image_id      = "ami-077e2fabf29e9a90b"
  instance_type = "t3.micro"
  key_name      = "ic-key"

  network_interfaces {
    associate_public_ip_address = true // change to false
    security_groups             = [aws_security_group.sg_direct-app-server.id]
    subnet_id                   = aws_subnet.aws-test-sab-pub-1.id // to change with private subnet
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name                  = "ci-database"
      Owner                 = "fr.abate@reply.it"
      DateOfDecommission    = formatdate("YYYY-MM-DD", timeadd(timestamp(), "1209600s"))
      Schedule              = "reply-office-hours-weekend"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name                  = "ci-database"
      Owner                 = "fr.abate@reply.it"
      DateOfDecommission    = formatdate("YYYY-MM-DD", timeadd(timestamp(), "1209600s"))
      Schedule              = "reply-office-hours-weekend"
    }
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install docker -y
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo docker run --name postgres-container \
      -e POSTGRES_USER=cardsisland_web \
      -e POSTGRES_PASSWORD=cardsisland_web \
      -e POSTGRES_DB=database \
      -p 5432:5432 \
      -d --restart always postgres
    sudo systemctl restart docker
  EOF
  )

  instance_initiated_shutdown_behavior = "terminate"
}