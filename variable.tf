
variable "aws_region" {
  default = "us-east-2"
}

variable "db_cluster_identifier" {
  default = "mysql-cluster"
}

variable "db_name" {
  default = "supernovadb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID for the RDS instance"
}

variable "subnet_ids" {
  description = "List of subnet IDs for Multi-AZ deployment"
  type        = list(string)
}

variable "instance_class" {
  default = "db.t3.medium"
}

variable "allocated_storage" {
  default = 20
}

variable "allowed_cidr" {
  default = "10.0.0.0/8" # Change for security
}
