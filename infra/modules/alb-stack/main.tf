resource "aws_lb" "bugnyan_web_alb" {
  name               = var.web_load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_alb_sg_id]
  subnets            = var.vpc_public_subnets

  enable_deletion_protection = false

  tags = merge(
    local.global_tags, {
      Name = "${var.web_load_balancer_name}-web-alb"
    }
  )
}

resource "aws_lb_target_group" "bugnyan_web_alb_tg" {
  name             = "${var.web_load_balancer_name}-alb-tg"
  port             = 80
  protocol         = "HTTP"
  ip_address_type  = "ipv4"
  vpc_id           = var.vpc_id
  protocol_version = "HTTP1"
  target_type      = "instance"

  health_check {
    protocol            = "HTTP"
    path                = "/index.html"
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.web_load_balancer_name}-alb-tg"
    }
  )
}

resource "aws_lb_listener" "bugnyan_web_alb_listener" {
  load_balancer_arn = aws_lb.bugnyan_web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bugnyan_web_alb_tg.arn
  }
}

resource "aws_lb" "bugnyan_app_alb" {
  name               = var.app_load_balancer_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.app_alb_sg_id]
  subnets            = var.vpc_private_subnets

  enable_deletion_protection = false

  tags = merge(
    local.global_tags, {
      Name = "${var.app_load_balancer_name}-app-alb"
    }
  )
}

resource "aws_lb_target_group" "bugnyan_app_alb_tg" {
  name             = "${var.app_load_balancer_name}-alb-tg"
  port             = 80
  protocol         = "HTTP"
  ip_address_type  = "ipv4"
  vpc_id           = var.vpc_id
  protocol_version = "HTTP1"
  target_type      = "instance"

  health_check {
    protocol            = "HTTP"
    path                = "/app/index.html"
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.app_load_balancer_name}-alb-tg"
    }
  )
}

resource "aws_lb_listener" "bugnyan_app_alb_listener" {
  load_balancer_arn = aws_lb.bugnyan_app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bugnyan_app_alb_tg.arn
  }
}