data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.db_instance_identifier}-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.db_instance_identifier}-subnet-group"
  }
}

resource "aws_db_parameter_group" "rds_param_group" {
  name   = "${var.db_engine}-param-group"

  family = (
    var.db_engine == "postgres" ? "postgres16" :
    var.db_engine == "mysql"    ? "mysql8.0" :
    ""
  )

  tags = {
    Name = "${var.db_engine}-param-group"
  }
}


resource "aws_db_instance" "rds" {
  identifier               = var.db_instance_identifier
  engine                   = var.db_engine
  engine_version           = var.db_engine_version
  instance_class           = var.db_instance_class
  db_name                  = var.db_name
  username                 = local.db_credentials.username
  password                 = local.db_credentials.password
  allocated_storage        = var.db_allocated_storage
  vpc_security_group_ids   = var.vpc_security_group_ids
  db_subnet_group_name     = aws_db_subnet_group.rds_subnet_group.name
  parameter_group_name     = aws_db_parameter_group.rds_param_group.name
  multi_az                 = var.multi_az
  publicly_accessible      = var.publicly_accessible
  backup_retention_period  = var.backup_retention_period
  skip_final_snapshot      = true

  tags = {
    Name = var.db_instance_identifier
  }
}