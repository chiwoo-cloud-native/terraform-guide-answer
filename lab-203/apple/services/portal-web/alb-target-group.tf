resource "aws_lb_target_group" "blue" {
  name        = format("%s-tg", local.app_name)
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.this.id

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 30
    interval            = 60
  }

  tags = merge(local.tags,
    { Name = format("%s-tg", local.app_name) }
  )

}

resource "aws_lb_target_group_attachment" "portal" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.portal.id
  port             = 80
}
