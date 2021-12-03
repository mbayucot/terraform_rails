resource "aws_ecs_cluster" "web" {
  name = var.cluster

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

