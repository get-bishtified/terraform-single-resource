variable "aws_region" {
  description = "AWS region to deploy Grafana"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  default     = "ami-0144277607031eca2" # Update if needed
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "allowed_cidr" {
  description = "CIDR block allowed to access Grafana & SSH"
  default     = "0.0.0.0/0"
}
