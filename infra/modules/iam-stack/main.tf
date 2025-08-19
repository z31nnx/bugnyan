resource "aws_iam_role" "bugnyan_ops_role" {
  name        = var.ops_role_name
  description = "ops role to access SSM and CloudWatch monitoring"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    local.global_tags, {
      Name = "${var.ops_role_name}"
    }
  )
}

resource "aws_iam_role_policy_attachment" "bugnyan_ops_role_policy_attachment" {
  for_each = local.role_policies

  role       = aws_iam_role.bugnyan_ops_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "bugnyan_ops_role_instance_profile" {
  name = "bugnyan_ops_role_instance_profile"
  role = aws_iam_role.bugnyan_ops_role.name
}