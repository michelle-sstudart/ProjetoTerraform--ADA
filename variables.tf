variable "aws_region" {
  description = "Regiao da AWS onde a infraestrutura sera criada"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instancia EC2"
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Numero de instancias EC2 a serem criadas"
  type        = number
  default     = 3
}

variable "db_password" {
  description = "Senha do banco de dados RDS"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_name" {
  description = "Nome do banco de dados para o RDS"
  type        = string
  default     = "green_books_db"
}

variable "db_username" {
  description = "usuario banco de dados para o RDS"
  type        = string
  default     = "admin"
}
variable "public_subnet_id" {
  description = "ID da Subnet Pública onde a NAT Gateway será configurada"
  type        = string
}

variable "private_subnet_id" {
  description = "ID da Subnet Privada"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "nat_gateway_enabled" {
  description = "Habilita a NAT Gateway"
  type        = bool
  default     = true
}

variable "eip_nat_gateway" {
  description = "Elastic IP para a NAT Gateway"
  type        = string
}



variable "s3_static_bucket_name" {
  description = "Nome do bucket para arquivos estáticos"
  type        = string
  default     = "green-books-static-files"
}

variable "s3_digital_products_bucket_name" {
  description = "Nome do bucket para produtos digitais"
  type        = string
  default     = "green-books-digital-products"
}

variable "alb_name" {
  description = "Nome do Load Balancer"
  type        = string
  default     = "green-books-alb"
}

variable "cloudfront_price_class" {
  description = "Classe de preço do CloudFront"
  type        = string
  default     = "PriceClass_200"
}

variable "region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "logs_bucket" {
  description = "Bucket para armazenar os logs do CloudFront"
  type        = string
  default     = "mylogs.s3.amazonaws.com"
}


variable "environment" {
  description = "Nome ambiente"
  default     = "production"
}