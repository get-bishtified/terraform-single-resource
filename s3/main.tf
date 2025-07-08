provider "aws" {
  region = var.region
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "shankaz-bucket-demo" {
  bucket = "${var.project_name}-bucket-${random_id.suffix.hex}"

  tags = {
    Name        = "${var.project_name}-bucket"
    Environment = var.environment
  }
}


resource "aws_iam_role" "ec2-demo-role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.project_name}-role"
    Environment = var.environment
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ec2-demo-role.name
}
