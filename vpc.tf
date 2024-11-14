resource "aws_vpc" "green_books_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "GreenBooksVPC"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.green_books_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnetA"
  }
}
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.green_books_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnetB"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.green_books_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnetC"
  }
}

resource "aws_db_subnet_group" "rds_subnet_vpc" {
  name        = "green-books-db-subnet-group"
  description = "Subnet group for GreenBooks RDS"
  subnet_ids  = [aws_subnet.private_subnet.id]

  tags = {
    Name = "GreenBooks RDS Subnet Group"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.green_books_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "PrivateSubnet"
  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.green_books_vpc.id

  tags = {
    Name = "green-books-internet-gateway"
  }
}
# Elastic IP para a NAT Gateway
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  depends_on = [aws_eip.nat_eip]
}

# Tabela de Roteamento para Subnet Privada
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
}

# Rota para a NAT Gateway na Tabela de Roteamento Privada
resource "aws_route" "private_nat_gateway_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Associação da Tabela de Roteamento Privada com a Subnet Privada
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

