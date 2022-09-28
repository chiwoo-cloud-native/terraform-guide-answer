locals {
  name_prefix = format("%s-%s", var.project, var.region_code)
  ec2_name    = format("%s-bastion", local.name_prefix)
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = var.instance_type

  root_block_device {
    volume_type = "gp3"
    volume_size = 10
  }

  ebs_optimized           = false
  disable_api_termination = true
  subnet_id               = tolist(data.aws_subnets.public.ids)[0]
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids  = [aws_security_group.bastion.id]

  tags = merge(var.tags,
    {
      Name = local.ec2_name
      OS   = "ubuntu"
    }
  )

}
