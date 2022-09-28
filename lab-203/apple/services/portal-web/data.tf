data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${local.name_prefix}-vpc"]
  }
}

# app subnet
data "aws_subnets" "app" {
  # vpc_id = var.vpc_id
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${local.name_prefix}-vpc-app-*"]
  }
}

#
data "template_file" "user_data" {
  template = file("templates/nginx.j2")
}

# key-pair
data "aws_key_pair" "key" {
  key_name = "${var.project}-keypair"
}

# ALB Security-Group
data "aws_security_group" "alb" {
  name = "${local.name_prefix}-front-alb-sg"
}

# ALB listener
data "aws_lb" "front" {
  name = "${local.name_prefix}-front-alb"
}

data "aws_lb_listener" "front" {
  load_balancer_arn = data.aws_lb.front.arn
  port              = 443
}


