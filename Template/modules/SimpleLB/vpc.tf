resource "aws_vpc" "SimpleLB-VPC" {
  cidr_block = var.VPC-Subnet
  tags = {
    Name = var.VPC
  }
}