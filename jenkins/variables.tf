variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  default = "shankaz"
}

variable "allowed_ip" {
  description = "Your IP for SSH access"
  default = "0.0.0.0/0"
}