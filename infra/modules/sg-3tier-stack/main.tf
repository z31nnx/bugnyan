resource "aws_security_group" "bugnyan_public_alb" {
  name        = "${var.sg_name}-frontend-alb-sg"
  description = "Bugnyan ALB public entry"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.frontend_alb_ports
    iterator = port

    content {
      from_port   = port.value
      to_port     = port.value
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.sg_name}-frontend-alb-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_frontend_sg" {
  name        = "${var.sg_name}-frontend-sg"
  description = "Bugnyan frontend instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.frontend_instance_ports
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      security_groups = [aws_security_group.bugnyan_public_alb.id]
      protocol        = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.sg_name}-frontend-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_backend_alb" {
  name        = "${var.sg_name}-backend-alb-sg"
  description = "Bugnyan backend internal ALB"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.backend_alb_ports
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      security_groups = [aws_security_group.bugnyan_frontend_sg.id]
      protocol        = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.sg_name}-backend-alb-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_backend_sg" {
  name        = "${var.sg_name}-backend-sg"
  description = "Bugnyan backend instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.backend_instance_ports
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      security_groups = [aws_security_group.bugnyan_backend_alb.id]
      protocol        = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.sg_name}-backend-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_database_sg" {
  name        = "${var.sg_name}-database-sg"
  description = "Bugnyan database sg"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.database_port
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      security_groups = [aws_security_group.bugnyan_backend_sg.id]
      protocol        = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.sg_name}-database-sg"
    }
  )
}