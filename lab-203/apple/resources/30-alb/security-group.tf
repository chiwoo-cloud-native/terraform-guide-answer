resource "aws_security_group" "alb" {
  name   = format("%s-sg", local.alb_name)
  vpc_id = var.vpc_id

  tags = merge(var.tags,
    {
      Name = format("%s-sg", local.alb_name)
    }
  )
}

resource "aws_security_group_rule" "in_80" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "in_https" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}
