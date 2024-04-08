output "ecs_service_name" {
  value = aws_ecs_service.my_ecs_service.name
}

output "ecs_service_dns" {
  value = aws_ecs_service.my_ecs_service.load_balancer.first(lookup("0", aws_ecs_service.my_ecs_service.load_balancer.keys())).dns_name
}

