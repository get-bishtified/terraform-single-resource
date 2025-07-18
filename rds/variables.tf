variable "db_engine" {
  description = "Database engine (e.g., postgres or mysql)"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Version of the database engine"
  type        = string
  default     = "16.1"
}

variable "db_instance_identifier" {
  description = "Unique name for the DB instance"
  type        = string
  default     = "demo-postgres-instance"
}

variable "db_instance_class" {
  description = "Instance type for RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "masteruser"
}

variable "db_secret_name" {
  description = "Secrets Manager name that holds DB credentials"
  type        = string
  default     = "rds-demo-db-secret"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate"
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for subnet group"
  type        = list(string)
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention in days"
  type        = number
  default     = 7
}

variable "publicly_accessible" {
  description = "Allow public access to the DB"
  type        = bool
  default     = false
}