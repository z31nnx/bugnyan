output "sg_alb_public_id" { value = aws_security_group.bugnyan_public_alb.id }
output "sg_alb_internal_id" { value = aws_security_group.bugnyan_backend_alb.id }
output "sg_frontend_id" { value = aws_security_group.bugnyan_frontend_sg.id }
output "sg_backend_id" { value = aws_security_group.bugnyan_backend_sg.id }
output "sg_database_id" { value = aws_security_group.bugnyan_database_sg.id }
