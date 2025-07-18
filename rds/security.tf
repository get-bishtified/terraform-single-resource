resource "aws_security_group" "rds_sg" {
  name        = "rds-access"
  description = "Allow DB access"
  vpc_id      = "vpc-09416282b6b989173"

  ingress {
    from_port   = 5432 # or 3306 for MySQL
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Use 0.0.0.0/0 only if necessary
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
