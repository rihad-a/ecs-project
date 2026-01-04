resource "aws_lb" "terraform-alb" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets           = [aws_subnet.public_1.id , aws_subnet.public_2.id]

  tags = {
    Name = "terraform-alb"
    Environment = "production"
  }
}

resource "aws_lb_listener" "alb_listener_https" {
   load_balancer_arn    = aws_lb.terraform-alb.id
   port                 = var.alb-port-1
   protocol             = "HTTPS"
   certificate_arn = aws_acm_certificate.cert.arn
   default_action {
    target_group_arn = aws_lb_target_group.alb-tg.id
    type             = "forward"
  }
}

resource "aws_lb_listener_certificate" "https" {
  listener_arn    = aws_lb_listener.alb_listener_https.arn
  certificate_arn = aws_acm_certificate.cert.arn
}

resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  port              = var.alb-port-2
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
