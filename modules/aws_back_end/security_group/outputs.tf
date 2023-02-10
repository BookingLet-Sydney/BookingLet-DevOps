output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}


output "cluster_sg_id" {
  value = aws_security_group.cluster_sg.id
}

