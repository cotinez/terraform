provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name"  = "main"
    "Owner" = "admin"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    "Name" = "main_vpc_igw"
  }
}

# Public subnets
#####################
resource "aws_subnet" "public_sn_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-sn-1"
  }
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_subnet" "public_sn_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-sn-2"
  }
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_subnet" "public_sn_3" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-sn-3"
  }
  depends_on = [aws_internet_gateway.igw]
}

# Private subnets
######################
resource "aws_subnet" "private_sn_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "private-sn-1"
  }
}
resource "aws_subnet" "private_sn_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "private-sn-2"
  }
}
resource "aws_subnet" "private_sn_3" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1c"
  tags = {
    "Name" = "private-sn-3"
  }
}

# Outputs
output "main_vpc_name" {
  description = "The main VPC Name"
  value       = aws_vpc.main_vpc.tags.Name
}
output "main_vpc_owner" {
  description = "The main VPC Owner"
  value       = aws_vpc.main_vpc.tags.Owner
}
output "main_vpc_id" {
  description = "The main VPC ID"
  value       = aws_vpc.main_vpc.id
}
output "main_vpc_arn" {
  description = "The main VPC ARN"
  value       = aws_vpc.main_vpc.arn
}
