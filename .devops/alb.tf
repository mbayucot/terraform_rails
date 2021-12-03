resource "aws_lb" "web" {
  name               = var.elb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = var.subnets

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "web" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc
  target_type = "instance"
  idle_timeout = 5

  health_check {
    port                = 80
    protocol            = "HTTP"
    path                = var.lb_healthcheck_path
    interval            = 30
    timeout             = 20
    healthy_threshold   = 10
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}