# Add listener rule to Frontend ALB
resource "aws_lb_listener_rule" "this" {
  listener_arn = data.aws_lb_listener.front.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }

  condition {
    host_header {
      values = ["portal.*"]
    }
  }

  lifecycle {
    ignore_changes = [action]
  }
}
