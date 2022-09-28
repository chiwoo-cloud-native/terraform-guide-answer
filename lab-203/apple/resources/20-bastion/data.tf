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

# AWS EIP 를 이미 생성해 두어야 합니다.
data "aws_eip" "bastion" {
  filter {
    name   = "tag:Name"
    values = ["apple-bastion-eip"]
  }
}


# public subnet
data "aws_subnets" "public" {
  # vpc_id = var.vpc_id
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["${local.name_prefix}-vpc-pub-*"]
  }
}

# key-pair
data "aws_key_pair" "key" {
  key_name = "${var.project}-keypair"
}
