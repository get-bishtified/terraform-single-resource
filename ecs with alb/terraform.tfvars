aws_region         = "ap-south-1"
vpc_id             = "vpc-09416282b6b989173"
public_subnets     = ["subnet-0abbd9d7af9b59806", "subnet-01ddfa960971c29f7"]

cluster_name       = "demo-cluster"
task_family        = "demo-task"
task_cpu           = "256"
task_memory        = "512"
execution_role_arn = "arn:aws:iam::638900790108:role/ecsTaskExecutionRole"
container_name     = "demo-app"
container_image    = "nginx:latest"
container_port     = 80
