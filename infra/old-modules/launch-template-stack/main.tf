data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "bugnyan_web_launch_template" {
  name          = var.web_launch_template_name
  image_id      = data.aws_ami.amazon_linux_2.image_id
  instance_type = var.web_instance_type
  description   = "The web launch template for bugnyan_web"

  user_data = filebase64("${path.module}/web-userdata.sh")

  monitoring {
    enabled = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  ebs_optimized = true

  iam_instance_profile {
    name = var.iam_instance_profile_for_ec2
  }
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.global_tags, {
        Name = "${var.web_launch_template_name}-instance"
      }
    )
  }
  tag_specifications {
    resource_type = "volume"
    tags = merge(
      local.global_tags, {
        Name = "${var.web_launch_template_name}-volume"
      }
    )
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.web_launch_template_name}-web-asg-lt"
    }
  )

  # Creates the templayte first before destroying 
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "bugnyan_app_launch_template" {
  name          = var.app_launch_template_name
  image_id      = data.aws_ami.amazon_linux_2.image_id
  instance_type = var.app_instance_type
  description   = "The app launch template for bugnyan_app"

  user_data = filebase64("${path.module}/app-userdata.sh")

  monitoring {
    enabled = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  ebs_optimized = true

  iam_instance_profile {
    name = var.iam_instance_profile_for_ec2
  }
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.global_tags, {
        Name = "${var.app_launch_template_name}-instance"
      }
    )
  }
  tag_specifications {
    resource_type = "volume"
    tags = merge(
      local.global_tags, {
        Name = "${var.app_launch_template_name}-volume"
      }
    )
  }

  tags = merge(
    local.global_tags, {
      Name = "${var.app_launch_template_name}-app-asg-lt"
    }
  )

  # Creates the templayte first before destroying 
  lifecycle {
    create_before_destroy = true
  }
}