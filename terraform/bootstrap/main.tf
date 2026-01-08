# S3 Bucket Creation

resource "aws_s3_bucket" "s3" {
  bucket = "rihads3"
}

# Hosted Zone Creation

resource "aws_route53_zone" "networking" {
  name = "networking.rihad.co.uk"
 }

data "aws_route53_zone" "networking" {
  name = "networking.rihad.co.uk"
 }

output "ns" {
  value = "${data.aws_route53_zone.networking.name_servers}"
 }

## Linkage Of Route53 NS' to Cloudflare

 resource "cloudflare_dns_record" "route53-ns" {
  name    = "networking"
  count   = "${length(data.aws_route53_zone.networking.name_servers)}"
  ttl     = 300
  type    = "NS"
  content   = "${element(data.aws_route53_zone.networking.name_servers, count.index)}"
  zone_id = "415c05da9144abf5a32a57c25dfefe06"
}

# ECR Repo Creation

resource "aws_ecr_repository" "ecs-project" {
  name                 = "ecs-project"
}


