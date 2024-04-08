# Create ECS cluster
resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "my-ecs-cluster"
}

# Create ECS task definition
resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-task"
  cpu                      = 256 # CPU units (0.25 vCPU)
  memory                   = 512 # Memory in MiB
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name      = "my-container"
      image     = "your-ecr-repo-url:latest" # URL of your Docker image in ECR
      cpu       = 256
      memory    = 512
      essential = true
    }
  ])
}

# Create ECS service
resource "aws_ecs_service" "my_ecs_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.my_ecs_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet.id]
    security_groups  = [aws_security_group.my_security_group.id]
    assign_public_ip = true
  }
}

