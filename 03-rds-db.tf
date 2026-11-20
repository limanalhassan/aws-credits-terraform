# Activity: Create an Aurora or RDS database (US$20)
# ---------------------------------------------------
# Plain RDS Postgres on db.t4g.micro is the cheapest viable thing the
# activity will accept. Costs about US$0.016/hour for the instance plus
# storage. Destroy with `terraform destroy -target=aws_db_instance.app`
# or a full destroy as soon as the activity flips to Completed.

resource "random_password" "db" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_db_subnet_group" "app" {
  name       = "${var.name_prefix}-db-subnets"
  subnet_ids = data.aws_subnets.default.ids
}

resource "aws_security_group" "db" {
  name        = "${var.name_prefix}-db-sg"
  description = "No inbound. DB is not publicly reachable."
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "app" {
  identifier          = "${var.name_prefix}-db"
  engine              = "postgres"
  engine_version      = "16.4"
  instance_class      = "db.t4g.micro"
  allocated_storage   = 20
  storage_type        = "gp3"
  storage_encrypted   = true
  db_name             = var.db_name
  username            = var.db_username
  password            = random_password.db.result
  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false

  db_subnet_group_name   = aws_db_subnet_group.app.name
  vpc_security_group_ids = [aws_security_group.db.id]

  backup_retention_period = 0
  apply_immediately       = true
}
