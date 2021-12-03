region = "us-east-1"
vpc = "vpc-da4ceda7"
subnets = [
  "subnet-9736a3f1",
  "subnet-2b5f7b66",
  "subnet-10ce5f4f"
]

security_group = "sg-0279d6f0b158ed971"
elb_name = "demo-app-web-https"
target_group_name = "demo-app-web-https-tg"

cluster = "demo-app"
instance_type = "t2.micro"

lb_healthcheck_path = "/health_check"

desired_count = "1"
iam_role = "ecsInstanceRole"