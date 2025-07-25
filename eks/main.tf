terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"  # or any compatible version you're using

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_nat_gateway = false
  single_nat_gateway = true

  map_public_ip_on_launch = true 

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  enable_irsa = true
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
      iam_role_arn   = aws_iam_role.eks_node_role.arn
    }
  }

  # Remove unsupported block if error persists
  # cluster_addons = {
  #   coredns = {
  #     resolve_conflicts = "OVERWRITE"
  #   }
  # }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
