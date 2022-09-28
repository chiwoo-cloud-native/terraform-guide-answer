resource "aws_security_group" "alb" {
  name = format("%s-sg", local.alb_name)
  vpc_id = var.vpc_id

  tags = merge(var.tags,
    {
      Name = format("%s-sg", local.alb_name)
    }
  )
}

/*
resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  # Ops 담당자가 접속하는 Public-IP 로 제한
  cidr_blocks       = [0.0.0.0/0]
}
*/
