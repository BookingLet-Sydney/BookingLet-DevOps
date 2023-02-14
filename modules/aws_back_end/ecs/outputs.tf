output "cluster_name" {
  value = module.ecs.cluster_name
}

output "service_name" {
  value = aws_ecs_service.app.name
}