data "aws_route53_zone" "cna-storm" {
  name = "lab.cna.stormreply.com."
}

resource "aws_route53_record" "ec2-database-private-record" {
  zone_id = data.aws_route53_zone.cna-storm.id
  name    = "cidb.lab.cna.stormreply.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.database_instance.private_ip]
}