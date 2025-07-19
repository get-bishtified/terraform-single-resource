variable "db_engine" {
  default     = "postgres"
  description = "Database engine type"
}

variable "db_engine_version" {
  default     = "16.8"
  description = "Engine version"
}

variable "db_instance_identifier" {
  default     = "demo-postgres-instance"
  description = "RDS instance name"
}

variable "db_instance_class" {
  default     = "db.t3.micro"
  description = "Instance class"
}

variable "db_name" {
  default     = "appdb"
  description = "Initial DB name"
}

variable "db_secret_name" {
  description = "Name of Secrets Manager secret holding DB credentials"
}

variable "db_allocated_storage" {
  default     = 20
  description = "Storage in GB"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security groups for RDS"
}

variable "db_subnet_ids" {
  type        = list(string)
  description = "Subnets for subnet group"
}

variable "multi_az" {
  default     = false
}

variable "backup_retention_period" {
  default     = 7
}

variable "publicly_accessible" {
  default     = false
}
