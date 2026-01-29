resource "aws_db_subnet_group" "db-subnet" {
  name       = var.db_sub_name
  subnet_ids = [var.pri_sub_5a_id, var.pri_sub_6b_id] # Replace with your private subnet IDs
}

resource "aws_db_instance" "db" {
  identifier              = "bookdb-instance"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = true
  storage_type            = "gp2"
  storage_encrypted       = true
  publicly_accessible     = false
  skip_final_snapshot     = false
  final_snapshot_identifier = "bookdb-final-snapshot"
  backup_retention_period = 7


  deletion_protection         = true
  auto_minor_version_upgrade  = true
  copy_tags_to_snapshot       = true

  maintenance_window = "sun:02:00-sun:03:00"

  vpc_security_group_ids = [var.db_sg_id] 

  db_subnet_group_name = aws_db_subnet_group.db-subnet.name

  tags = {
    Name = "bookdb"
  }
}


