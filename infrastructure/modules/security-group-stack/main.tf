resource "aws_security_group" "bugnyan_web_alb_sg" {
  name        = var.bugnyan_web_alb_sg_name
  description = "Allow public entry anywhere"
  vpc_id      = var.bugnyan_vpc_id

  dynamic "ingress" {
    for_each = local.ports.web
    iterator = port

    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
      Name = "${var.bugnyan_web_alb_sg_name}-web-alb-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_web_asg_sg" {
  name        = var.bugnyan_web_asg_sg_name
  description = "Protect bugnyan web ec2 from public exposure"
  vpc_id      = var.bugnyan_vpc_id

  dynamic "ingress" {
    for_each = local.ports.web
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = [aws_security_group.bugnyan_web_alb_sg.id]
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
      Name = "${var.bugnyan_web_asg_sg_name}-web-asg-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_app_alb_sg" {
  name        = var.bugnyan_app_alb_sg_name
  description = "take traffic from bugnyan web ec2 instances"
  vpc_id      = var.bugnyan_vpc_id

  dynamic "ingress" {
    for_each = local.ports.app
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = [aws_security_group.bugnyan_web_asg_sg.id]
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
      Name = "${var.bugnyan_app_alb_sg_name}-app-alb-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_app_asg_sg" {
  name        = var.bugnyan_app_asg_sg_name
  description = "allow traffic from the app alb"
  vpc_id      = var.bugnyan_vpc_id

  dynamic "ingress" {
    for_each = local.ports.app
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = [aws_security_group.bugnyan_app_alb_sg.id]
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
      Name = "${var.bugnyan_app_asg_sg_name}-app-asg-sg"
    }
  )
}

resource "aws_security_group" "bugnyan_database_sg" {
  name        = var.bugnyan_database_sg_name
  description = "allow traffic bugnyan app ec2 instances"
  vpc_id      = var.bugnyan_vpc_id

  dynamic "ingress" {
    for_each = local.ports.database
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = [aws_security_group.bugnyan_app_asg_sg.id]
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
      Name = "${var.bugnyan_database_sg_name}-database-sg"
    }
  )
}