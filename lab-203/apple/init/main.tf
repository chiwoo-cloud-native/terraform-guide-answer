locals {
  name_prefix = format("%s-%s", var.project, var.region_code)
}

resource "aws_eip" "bastion" {
  vpc  = true
  tags = {
    Name = "apple-bastion-eip"
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private" {
  filename        = "${var.project}-keypair.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "public" {
  key_name   = "${var.project}-keypair"
  public_key = tls_private_key.key.public_key_openssh
}

