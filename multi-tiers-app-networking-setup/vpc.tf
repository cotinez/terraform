resource "aws_vpc" "VPC1" {
  cidr_block       = "10.10.0.0/16"

  tags = {
    Name = "VPC1"
  }
}

resource "aws_internet_gateway" "VPC1-igw" {
  vpc_id = aws_vpc.VPC1.id

  tags = {
    Name = "VPC1-igw"
  }
}