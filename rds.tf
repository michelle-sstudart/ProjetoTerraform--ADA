
resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Seguranca para o banco de dados RDS"
  vpc_id      = aws_vpc.green_books_vpc.id

  # Permitir acesso apenas para as instâncias EC2
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "green_books_rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_vpc.name

  tags = {
    Name = "GreenBooks RDS Instance"

    skip_final_snapshot = true
  }
}

