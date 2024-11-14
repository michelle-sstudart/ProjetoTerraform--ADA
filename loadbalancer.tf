resource "aws_lb" "app_load_balancer" {
  name               = "green-books-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  tags = {
    Name = "GreenBooksALB"
  }
}

resource "aws_lb_target_group" "app_target_group" {
  name     = "green-books-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.green_books_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "GreenBooksTargetGroup"
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "target_attachment" {
  count            = 3
  target_group_arn = aws_lb_target_group.app_target_group.arn
  target_id        = aws_instance.backend_instance[count.index].id
  port             = 80
}


resource "aws_lb" "front_end" {
  name               = "my-front-end-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id, aws_subnet.public_subnet_c.id]

  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}

# Listener para o Load Balancer
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end_tg.arn
  }
}
