resource "aws_alb" "web" {
  name               = var.elb_name
  internal                   = false
  enable_deletion_protection = false
  security_groups    = [var.security_group]
  subnets            = var.subnets

  tags = {
    Environment = "production"
  }
}

resource "aws_alb_target_group" "web" {
  name     = var.target_group_name
  port     = 80
  depends_on           = [aws_alb.web]
  protocol = "HTTP"
  vpc_id   = var.vpc
  target_type = "ip"
  deregistration_delay = 15

  health_check {
    port                = "traffic-port"
    protocol            = "HTTP"
    path                = var.lb_healthcheck_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 10
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_alb_listener" "web" {
  load_balancer_arn = aws_alb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web.arn
  }
}