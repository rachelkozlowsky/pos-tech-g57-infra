# ======================================
# Application Load Balancer Configuration
# ======================================

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.projectName}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets           = aws_subnet.subnet_public[*].id

  enable_deletion_protection = false

  tags = merge(var.tags, {
    Name = "${var.projectName}-alb"
    Type = "Load Balancer"
  })
}

# Security Group para ALB
resource "aws_security_group" "alb" {
  name_prefix = "${var.projectName}-alb-"
  vpc_id      = aws_vpc.vpc_fiap.id
  description = "Security group for Application Load Balancer"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.projectName}-alb-sg"
    Type = "Security Group"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# Target Group para aplicação
resource "aws_lb_target_group" "app" {
  name     = "${var.projectName}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_fiap.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = merge(var.tags, {
    Name = "${var.projectName}-app-target-group"
    Type = "Target Group"
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    
    forward {
      target_group {
        arn    = aws_lb_target_group.app.arn
        weight = 100
      }
    }
  }

  tags = merge(var.tags, {
    Name = "${var.projectName}-http-listener"
  })
}