aws_region         = "us-east-1"
db_cluster_identifier  = "supernova-mysql-cluster"
db_name            = "supernovadb"
db_username        = "admin"
db_password        = "supernova!123"
vpc_id             = "vpc-0f355ea50c7c78ae4"
subnet_ids         = ["subnet-08a53015105625cc3", "subnet-02bbe50a41935850a", "subnet-00fc4bae2e83199f0"]
instance_class     = "db.m5d.large"
allocated_storage  = 5
allowed_cidr       = "10.5.0.0/22"
