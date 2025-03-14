
provider "aws" {
  region = var.aws_region
}

# Create Security Group for MySQL RDS
resource "aws_security_group" "rds_sg" {
  name        = "supernova-mysql-cluster-sg"
  description = "Allow MySQL inbound traffic"        
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysql-cluster-sg"
  }
}

#Create RDS Subnet Group
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "supernova-mysql-subnet-group"        
  subnet_ids = var.subnet_ids

  tags = {
    Name = "mysql-subnet-group"
  }
}

# Create RDS MySQL Instance (Multi-AZ)
 resource "aws_rds_cluster" "supernova_cluster" {
  cluster_identifier  = var.db_cluster_identifier
  engine              = "mysql"
  engine_version      = "8.0.40"
  master_username     = var.db_username
  master_password     = var.db_password
  db_cluster_instance_class = var.instance_class
  allocated_storage   = var.allocated_storage
  storage_type = "gp3"
  storage_encrypted   = true
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Backup & Deletion Protection
  backup_retention_period    = 7
  preferred_backup_window = "02:00-03:00"
  skip_final_snapshot        = false
  final_snapshot_identifier  = "${var.db_cluster_identifier}-final-snapshot"

  tags = {
    Name = "MySQLCluster"
  }

}
