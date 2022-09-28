locals {
  name_prefix = format("%s-%s", var.project, var.region_code)
  alb_name    = format("%s-front-alb", local.name_prefix)
}

resource "aws_lb" "this" {
  name = local.alb_name

  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb.id]
  subnets            = toset(data.aws_subnets.pub.ids)

  idle_timeout                     = 60
  enable_cross_zone_load_balancing = false
  enable_deletion_protection       = false
  enable_http2                     = true
  ip_address_type                  = "ipv4"
  drop_invalid_header_fields       = false

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  tags = merge(
    var.tags,
    { Name = local.alb_name },
  )

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn

  port            = 443
  protocol        = "HTTPS"
  certificate_arn = data.aws_acm_certificate.this.arn
  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Service Unavailable"
      status_code  = "503"
    }
  }

}
