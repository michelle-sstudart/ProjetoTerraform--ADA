resource "aws_s3_bucket" "static_files" {
  bucket = "green-books-static-files"

  tags = {
    Name = "StaticFilesBucket"
  }
}
resource "aws_s3_bucket" "digital_products" {
  bucket = "green-books-digital-products"

  tags = {
    Name = "DigitalProductsBucket"
  }
}


# Definindo o ACL do Bucket
resource "aws_s3_bucket_acl" "static_files_acl" {
  bucket = aws_s3_bucket.static_files.id
  acl    = "public-read"
}

resource "aws_s3_bucket_acl" "digital_products_acl" {
  bucket = aws_s3_bucket.digital_products.id
  acl    = "public-read"
}
