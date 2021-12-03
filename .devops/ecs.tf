resource "aws_ecs_cluster" "web" {
  name = var.cluster

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                = "web"
  container_definitions = file("task-definitions/service.json")
}

resource "aws_ecs_service" "web" {
  name            = "mongodb"
  cluster         = aws_ecs_cluster.web.id
  task_definition = aws_ecs_task_definition.web.arn
  desired_count   = var.desired_count
  iam_role        = var.iam_role

  load_balancer {
    target_group_arn = aws_lb_target_group.web.arn
    container_name   = "web"
    container_port   = 80
  }
}



# ECS
configure-cluster:
ecs-cli configure --cluster $(CLUSTER) --region $(REGION) --default-launch-type EC2 --config-name $(CLUSTER)

create-cluster:
ecs-cli up --keypair aws-localist --subnets $(SUBNETS) --security-group $(SECURITY_GROUP) --vpc $(VPC) --instance-role $(INSTANCE_ROLE) --size $(DESIRED_COUNT) --instance-type $(INSTANCE_TYPE) --cluster-config $(CLUSTER)

start-cluster:
ecs-cli compose --project-name $(PROJECT_NAME) service up --create-log-groups --cluster-config $(CLUSTER) --target-group-arn $(TARGET_GROUP) --deployment-max-percent $(MAX_PERCENT) --deployment-min-healthy-percent $(MIN_PERCENT) --container-name $(CONTAINER_NAME) --container-port 443
ecs-cli compose --project-name $(PROJECT_NAME) --cluster-config $(CLUSTER) service scale $(DESIRED_COUNT)

deploy:
aws ecs update-service --cluster $(CLUSTER) --service $(PROJECT_NAME) --force-new-deployment

scale:
#ecs-cli compose --project-name $(PROJECT_NAME) --cluster-config $(CLUSTER) service scale $(DESIRED_COUNT)
#aws ecs update-service --cluster $(CLUSTER) --service $(PROJECT_NAME) --desired-count 3
#ecs-cli compose --cluster $(CLUSTER) --project-name $(PROJECT_NAME) service scale 3 --deployment-max-percent 150 --deployment-min-healthy-percent 50

down-cluster:
aws ecs update-service --cluster $(CLUSTER) --service $(PROJECT_NAME) --desired-count 0
aws ecs delete-service --cluster $(CLUSTER) --service $(PROJECT_NAME)
ecs-cli down --force --cluster-config $(CLUSTER)