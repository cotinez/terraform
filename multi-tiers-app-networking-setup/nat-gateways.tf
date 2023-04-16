# EIPs for NAT Gateways

resource "aws_eip" "us-east-1a-eip" {
  vpc      = true
}

resource "aws_eip" "us-east-1b-eip" {
  vpc      = true
}

resource "aws_eip" "us-east-1c-eip" {
  vpc      = true
}


# NAT Gateways

resource "aws_nat_gateway" "us-east-1a-nat-gw" {
  allocation_id = aws_eip.us-east-1a-eip.id
  subnet_id     = aws_subnet.web-sn-1a.id

  tags = {
    Name = "us-east-1a-nat-gw"
  }

  depends_on = [aws_internet_gateway.VPC1-igw]
}

resource "aws_nat_gateway" "us-east-1b-nat-gw" {
  allocation_id = aws_eip.us-east-1b-eip.id
  subnet_id     = aws_subnet.web-sn-1b.id

  tags = {
    Name = "us-east-1b-nat-gw"
  }

  depends_on = [aws_internet_gateway.VPC1-igw]
}

resource "aws_nat_gateway" "us-east-1c-nat-gw" {
  allocation_id = aws_eip.us-east-1c-eip.id
  subnet_id     = aws_subnet.web-sn-1c.id

  tags = {
    Name = "us-east-1c-nat-gw"
  }

  depends_on = [aws_internet_gateway.VPC1-igw]
}