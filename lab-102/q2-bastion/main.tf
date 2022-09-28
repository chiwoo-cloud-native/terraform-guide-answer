locals {
  name_prefix = "bastion"

  tags = {
    ManagedBy = "Terraform"
    Team      = "DevOps"
    Owner     = "symplesims@gmail.com"
  }
}

resource "aws_security_group" "bastion" {
  name = format("%s-sg", local.name_prefix)

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [
      data.aws_vpc.default.cidr_block
    ]
  }

  tags = merge(local.tags,
    {
      Name = format("%s-sg", local.name_prefix)
    }
  )
}

resource "aws_instance" "bastion" {

  ami           = "ami-08f869ae259b6bc98"
  instance_type = "t2.micro"

  availability_zone      = data.aws_subnet.sn.availability_zone
  subnet_id              = data.aws_subnet.sn.id
  vpc_security_group_ids = [aws_security_group.bastion.id]

  tags = merge(local.tags,
    {
      Name = format("%s-ec2", local.name_prefix)
      OS   = "ubuntu"
    }
  )

}
