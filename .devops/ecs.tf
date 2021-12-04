resource "aws_ecs_cluster" "web" {
  name = var.cluster

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                = "web"
  cpu                   = 256
  memory                = 512
  network_mode          = "awsvpc"
  container_definitions = file("task-definitions/service.json")
}

resource "aws_ecs_service" "web" {
  name            = "demo-service-web"
  cluster         = aws_ecs_cluster.web.id
  task_definition = aws_ecs_task_definition.web.arn
  desired_count   = var.desired_count

  load_balancer {
    target_group_arn = aws_lb_target_group.web.arn
    container_name   = "web"
    container_port   = 80
  }
}