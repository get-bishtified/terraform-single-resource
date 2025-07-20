variable "aws_region" {}
variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}

variable "cluster_name" {}
variable "task_family" {}
variable "task_cpu" {}
variable "task_memory" {}
variable "execution_role_arn" {}
variable "container_name" {}
variable "container_image" {}
variable "container_port" {}
