variable "db_engine" {
  description = "The database engine to use (postgres or mysql)"
  type        = string
  default     = "postgres"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_name" {
  default = "demo-db"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  sensitive = true
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "db_allocated_storage" {
  default = 20
}
