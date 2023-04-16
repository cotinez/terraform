# Public route table

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.VPC1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC1-igw.id
  }

  tags = {
    Name = "public-rt"
  }
}



# us-east-1a AZ private route table


resource "aws_route_table" "us-east-1a-private-rt" {
  vpc_id = aws_vpc.VPC1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.us-east-1a-nat-gw.id
  }

  tags = {
    Name = "us-east-1a-private-rt"
  }
}

# us-east-1b AZ private route table

resource "aws_route_table" "us-east-1b-private-rt" {
  vpc_id = aws_vpc.VPC1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.us-east-1b-nat-gw.id
  }

  tags = {
    Name = "us-east-1b-private-rt"
  }
}

# us-east-1c AZ private route table

resource "aws_route_table" "us-east-1c-private-rt" {
  vpc_id = aws_vpc.VPC1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.us-east-1c-nat-gw.id
  }

  tags = {
    Name = "us-east-1c-private-rt"
  }
}


# Route table associations

# Pubilc associations

resource "aws_route_table_association" "public-rt-web-sn-1a" {
  subnet_id      = aws_subnet.web-sn-1a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-rt-web-sn-1b" {
  subnet_id      = aws_subnet.web-sn-1b.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-rt-web-sn-1c" {
  subnet_id      = aws_subnet.web-sn-1c.id
  route_table_id = aws_route_table.public-rt.id
}

# Private us-east-1a associations

resource "aws_route_table_association" "private-rt-app-sn-1a" {
  subnet_id      = aws_subnet.app-sn-1a.id
  route_table_id = aws_route_table.us-east-1a-private-rt.id
}

resource "aws_route_table_association" "private-rt-db-sn-1a" {
  subnet_id      = aws_subnet.db-sn-1a.id
  route_table_id = aws_route_table.us-east-1a-private-rt.id
}

resource "aws_route_table_association" "private-rt-resv-sn-1a" {
  subnet_id      = aws_subnet.resv-sn-1a.id
  route_table_id = aws_route_table.us-east-1a-private-rt.id
}


# Private us-east-1b associations

resource "aws_route_table_association" "private-rt-app-sn-1b" {
  subnet_id      = aws_subnet.app-sn-1b.id
  route_table_id = aws_route_table.us-east-1b-private-rt.id
}

resource "aws_route_table_association" "private-rt-db-sn-1b" {
  subnet_id      = aws_subnet.db-sn-1b.id
  route_table_id = aws_route_table.us-east-1b-private-rt.id
}

resource "aws_route_table_association" "private-rt-resv-sn-1b" {
  subnet_id      = aws_subnet.resv-sn-1b.id
  route_table_id = aws_route_table.us-east-1b-private-rt.id
}
# Private us-east-1c associations

resource "aws_route_table_association" "private-rt-app-sn-1c" {
  subnet_id      = aws_subnet.app-sn-1c.id
  route_table_id = aws_route_table.us-east-1c-private-rt.id
}

resource "aws_route_table_association" "private-rt-db-sn-1c" {
  subnet_id      = aws_subnet.db-sn-1c.id
  route_table_id = aws_route_table.us-east-1c-private-rt.id
}

resource "aws_route_table_association" "private-rt-resv-sn-1c" {
  subnet_id      = aws_subnet.resv-sn-1c.id
  route_table_id = aws_route_table.us-east-1c-private-rt.id
}