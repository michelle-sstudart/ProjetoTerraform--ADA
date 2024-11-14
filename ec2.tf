
locals {
  subnets = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id, aws_subnet.public_subnet_c.id]
}

resource "aws_instance" "backend_instance" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = element(var.subnets, count.index % length(var.subnets))

  tags = {
    Name = "BackendInstance-${count.index + 1}"
  }
}
