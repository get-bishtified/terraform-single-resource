variable "region" {
  default = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Key pair name to SSH into EC2"
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instance will be launched"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
}
