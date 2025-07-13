# ALB for OpenProject
resource "aws_lb" "openproject" {
  name               = "openproject-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "openproject-alb"
  }
}

# ALB for DevLake
resource "aws_lb" "devlake" {
  name               = "devlake-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "devlake-alb"
  }
}

# Target Group for OpenProject (port 8080 on instance)
resource "aws_lb_target_group" "openproject" {
  name     = "openproject-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

# Target Group for DevLake (port 4000 on instance)
resource "aws_lb_target_group" "devlake" {
  name     = "devlake-tg"
  port     = 4000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

# Target attachment for OpenProject instance
resource "aws_lb_target_group_attachment" "openproject" {
  target_group_arn = aws_lb_target_group.openproject.arn
  target_id        = var.openproject_instance
  port             = 80
}

# Target attachment for DevLake instance
resource "aws_lb_target_group_attachment" "devlake" {
  target_group_arn = aws_lb_target_group.devlake.arn
  target_id        = var.devlake_instance
  port             = 4000
}

# Listener for OpenProject ALB
resource "aws_lb_listener" "openproject_http" {
  load_balancer_arn = aws_lb.openproject.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.openproject.arn
  }
}

# Listener for DevLake ALB
resource "aws_lb_listener" "devlake_http" {
  load_balancer_arn = aws_lb.devlake.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devlake.arn
  }
}
