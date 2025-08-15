variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  default     = "ami-0c02fb55956c7d316"
}

variable "allowed_cidr" {
  description = "CIDR allowed to access Grafana and SSH"
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "Name of the AWS key pair for SSH"
}
