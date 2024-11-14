resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security group for EC2 backend instances"
  vpc_id      = aws_vpc.green_books_vpc.id

  # Permitir o acesso do Load Balancer
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]


  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2S Security Group"
  }
}

# Permitir acesso público
resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Seguranca para o Load Balancer"
  vpc_id      = aws_vpc.green_books_vpc.id

  # Permitir acesso público
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ALB Security Group"
  }
}