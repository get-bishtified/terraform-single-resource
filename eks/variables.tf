variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "nginx-vpc"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "nginx-eks-cluster"
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-south-1" # or whatever region you're using
}

