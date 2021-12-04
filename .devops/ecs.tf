resource "aws_ecs_cluster" "web" {
  name = var.cluster

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                = "web"
  requires_compatibilities = ["FARGATE"]
  cpu                   = 512
  memory                = 1024
  network_mode          = "awsvpc"
  container_definitions = file("task-definitions/service.json")
  task_role_arn            = "arn:aws:iam::099459909584:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::099459909584:role/ecsTaskExecutionRole"
}

resource "aws_ecs_service" "web" {
  name            = "demo-service-web"
  launch_type                        = "FARGATE"
  cluster         = aws_ecs_cluster.web.id
  task_definition = aws_ecs_task_definition.web.arn
  desired_count   = var.desired_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.web.arn
    container_name   = "web"
    container_port   = 80
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group]
    assign_public_ip = "true"
  }
}