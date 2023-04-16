
# us-east-1a AZ subnets

resource "aws_subnet" "web-sn-1a" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.0.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "web-sn-1a"
  }
}

resource "aws_subnet" "app-sn-1a" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.48.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "app-sn-1a"
  }
}

resource "aws_subnet" "db-sn-1a" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.96.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "db-sn-1a"
  }
}

resource "aws_subnet" "resv-sn-1a" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.144.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "resv-sn-1a"
  }
}


# us-east-1b AZ subnets

resource "aws_subnet" "web-sn-1b" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.16.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "web-sn-1b"
  }
}

resource "aws_subnet" "app-sn-1b" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.64.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "app-sn-1b"
  }
}

resource "aws_subnet" "db-sn-1b" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.112.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "db-sn-1b"
  }
}

resource "aws_subnet" "resv-sn-1b" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.160.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "resv-sn-1b"
  }
}



# us-east-1c AZ subnets

resource "aws_subnet" "web-sn-1c" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.32.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "web-sn-1c"
  }
}

resource "aws_subnet" "app-sn-1c" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.80.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "app-sn-1c"
  }
}

resource "aws_subnet" "db-sn-1c" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.128.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "db-sn-1c"
  }
}

resource "aws_subnet" "resv-sn-1c" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "10.10.176.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "resv-sn-1c"
  }
}




