resource "aws_lb_target_group" "target_group_heating" {
  name     = "tg-heating"
  port     = 3000
  protocol = "HTTP"
  protocol_version = "HTTP1"
  vpc_id   = var.vpc_id
  health_check {
    protocol = "HTTP"
    path = "/health-check"
}
}
resource "aws_lb_target_group_attachment" "heating" {
    target_group_arn = aws_lb_target_group.target_group_heating.arn
  target_id        = var.heating_instance_id
  port             = 3000
}

resource "aws_lb_target_group" "target_group_lighting" {
  name     = "tg-lighting"
  port     = 3000
  protocol = "HTTP"
  protocol_version = "HTTP1"
  vpc_id   = var.vpc_id
  health_check {
    protocol = "HTTP"
    path = "/health-check"
}
}
resource "aws_lb_target_group_attachment" "lighting" {
    target_group_arn = aws_lb_target_group.target_group_lighting.arn
  target_id        = var.lighting_instance_id
  port             = 3000
}

resource "aws_lb_target_group" "target_group_status" {
  name     = "tg-status"
  port     = 3000
  protocol = "HTTP"
  protocol_version = "HTTP1"
  vpc_id   = var.vpc_id
  health_check {
    protocol = "HTTP"
    path = "/health-check"
}
}
resource "aws_lb_target_group_attachment" "status" {
    target_group_arn = aws_lb_target_group.target_group_status.arn
  target_id        = var.status_instance_id
  port             = 3000
}

resource "aws_lb_target_group" "target_group_auth" {
  name     = "tg-auth"
  port     = 3000
  protocol = "HTTP"
  protocol_version = "HTTP1"
  vpc_id   = var.vpc_id
  health_check {
    protocol = "HTTP"
    path = "/health-check"
}
}
resource "aws_lb_target_group_attachment" "auth" {
    target_group_arn = aws_lb_target_group.target_group_auth.arn
  target_id        = var.auth_instance_id
  port             = 3000
}


resource "aws_lb" "load_balancer_public" {
  name               = "loadBalancerPublic"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.public_subnets
}

resource "aws_lb" "load_balancer_private" {
  name               = "loadBalancerPrivate"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.private_subnets
}

resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.load_balancer_public.arn
  port              = "3000"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_status.arn
  }
}

resource "aws_lb_listener_rule" "heating" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_heating.arn
  }

  condition {
    path_pattern {
      values = ["/api/heating/*"]
    }
  }
}

resource "aws_lb_listener_rule" "lighting" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_lighting.arn
  }

  condition {
    path_pattern {
      values = ["/api/lights/*"]
    }
  }
}

# Not really sure what to do with the private load balancer...

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.load_balancer_private.arn
  port              = "3000"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_auth.arn
  }
}