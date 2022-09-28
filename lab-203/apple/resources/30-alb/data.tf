#data "aws_caller_identity" "current" {}
#data "aws_partition" "current" {}

#data "aws_availability_zones" "this" {
#  state = "available"
#}

data "aws_acm_certificate" "this" {
  domain = var.domain
}

data "aws_route53_zone" "public" {
  name = var.domain
}

data "aws_subnets" "pub" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["${local.name_prefix}-vpc-pub-*"]
  }
}
