output "bugnyan_security_group_details" {
  value = {
    ids = {
      bugnyan_web_alb_sg = aws_security_group.bugnyan_web_alb_sg.id
      bugnyan_app_alb_sg = aws_security_group.bugnyan_app_alb_sg.id
    }
  }
}