resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_parameter_group" "db_param_group" {
  name   = "custom-db-params"
  family = var.db_engine == "postgres" ? "postgres16" : "mysql8.0"

  parameters = []
}

resource "aws_db_instance" "demo_rds_instance" {
  identifier              = "rds-${var.db_engine}-instance"
  allocated_storage       = var.db_allocated_storage
  engine                  = var.db_engine
  engine_version          = var.db_engine == "postgres" ? "16.1" : "8.0"
  instance_class          = var.db_instance_class
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = aws_db_parameter_group.db_param_group.name
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 7

  tags = {
    Name = "demo-tf-rds"
  }
}
