resource "aws_lb_target_group" "alb-tg" {
  name     = "alb-tg"
  port     = var.albtg-port
  target_type = "ip" 
  protocol = "HTTP"

  vpc_id   = aws_vpc.terraform_vpc.id
}
