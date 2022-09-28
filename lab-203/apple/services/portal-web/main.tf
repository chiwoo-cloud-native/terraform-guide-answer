locals {
  project     = var.project
  name_prefix = format("%s-%s", var.project, var.region_code)
  app_name    = format("%s-portal", local.name_prefix)

  tags = {
    Project     = var.project
    Environment = var.env
    Team        = var.team
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "portal" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = var.instance_type

  ebs_optimized           = false
  disable_api_termination = true
  subnet_id               = tolist(data.aws_subnets.app.ids)[0]
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids  = [aws_security_group.portal.id]
  iam_instance_profile    = aws_iam_instance_profile.this.name

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp3"
  }

  user_data = data.template_file.user_data.rendered

  tags = merge(local.tags,
    {
      Name = local.app_name
      OS   = "ubuntu"
      App  = "portal"
    }
  )

}
