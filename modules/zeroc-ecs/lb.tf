resource "aws_lb" "alb" {
  name                       = "${var.cluster_name}-zeroc-alb-${var.environment}"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.subnets
  enable_deletion_protection = false

  security_groups = [aws_security_group.sg.id]

  tags = {
    Name = "zeroc-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.cluster_name}-zeroc-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/api"
    protocol            = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# resource "aws_lb_listener" "zeroc_https_listener" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.ssl_certificate_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.zeroc_tg.arn
#   }
# }
