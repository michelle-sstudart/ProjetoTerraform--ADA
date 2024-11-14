output "vpc_id" {
  value = aws_vpc.green_books_vpc.id
}

output "ec2_public_ips" {
  value = [for instance in aws_instance.backend_instance : instance.public_ip]
}

output "s3_static_bucket_name" {
  value = aws_s3_bucket.static_files.bucket
}

output "load_balancer_dns" {
  value       = aws_lb.app_load_balancer.dns_name
  description = "DNS do Load Balancer para acessar o backend"
}

output "ec2_ami_id" {
  value       = data.aws_ami.latest_amazon_linux.id
  description = "AMI utilizada para as instancias EC2"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat_gateway.id
  description = "ID da NAT Gateway"
}

output "eip_nat_gateway" {
  value       = aws_eip.nat_eip.public_ip
  description = "Elastic IP associado à NAT Gateway"
}


output "cloudfront_s3_distribution_domain_name" {
  description = "Domínio da distribuição do CloudFront para S3"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_alb_distribution_domain_name" {
  description = "Domínio da distribuição do CloudFront para ALB"
  value       = aws_cloudfront_distribution.alb_distribution.domain_name
}
