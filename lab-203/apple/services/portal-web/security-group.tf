resource "aws_security_group" "portal" {
  name   = format("%s-sg", local.app_name)
  vpc_id = data.aws_vpc.this.id

  tags = merge(local.tags,
    {
      Name = format("%s-sg", local.app_name)
    }
  )
}

resource "aws_security_group_rule" "out_http" {
  security_group_id = aws_security_group.portal.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "out_https" {
  security_group_id = aws_security_group.portal.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "in_ssh" {
  security_group_id        = aws_security_group.portal.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = data.aws_security_group.alb.id
}

resource "aws_security_group_rule" "in_bastion" {
  security_group_id = aws_security_group.portal.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = [data.aws_vpc.this.cidr_block]
}

resource "aws_security_group_rule" "out_alb" {
  description              = local.app_name
  security_group_id        = data.aws_security_group.alb.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.portal.id
}
