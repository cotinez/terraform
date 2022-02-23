provider "aws" {
  region = var.region
  
}
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
        tags = {
      "Name" = "lab-vpc-noInternetSSMInstancesManaged"
    }
}
resource "aws_subnet" "private-sn" {
    availability_zone = var.az
    cidr_block = var.subnet_cidr_block
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      "Name" = "private-sn"
    }
  
}

resource "aws_route_table" "private-sn-RT" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      "Name" = "instances-managed-SSMPrivate-sn-RT"
    }
  
}

resource "aws_route_table_association" "private-sn-rt-association" {
    subnet_id = aws_subnet.private-sn.id
    route_table_id = aws_route_table.private-sn-RT.id
  
}

resource "aws_security_group" "managed-instance-sg" {
    name = "managed-instances-sg"
    description = "Managed instances security group. ALLOW ALL outbound traffic"
    vpc_id = aws_vpc.my_vpc.id
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      "Name" = "managed-instance-sg"
    }
  
}
resource "aws_security_group" "endpoints-sg" {
    name = "endpoints-sg"
    description = "SSM, SSMmessages and EC2messages endpoint security group. ALLOW HTTPS inbound traffic from managed instances network"
    vpc_id = aws_vpc.my_vpc.id
    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [aws_subnet.private-sn.cidr_block]
    }
    tags = {
      "Name" = "endpoints-sg"
    }
  
}
resource "aws_vpc_endpoint" "ssm-endpoint" {
  service_name = "com.amazonaws.us-east-1.ssm"
  vpc_id = aws_vpc.my_vpc.id
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [aws_subnet.private-sn.id]
  security_group_ids = [aws_security_group.endpoints-sg.id]
  tags = {
    "Name" = "ssm-endpoint"
  }

  
}
resource "aws_vpc_endpoint" "ssm-messages-endpoint" {
  service_name = "com.amazonaws.us-east-1.ssmmessages"
  vpc_id = aws_vpc.my_vpc.id
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [aws_subnet.private-sn.id]
  security_group_ids = [aws_security_group.endpoints-sg.id]
  tags = {
    "Name" = "ssmMessages-endpoint"
  }

  
}
resource "aws_vpc_endpoint" "ec2-messages-endpoint" {
  service_name = "com.amazonaws.us-east-1.ec2messages"
  vpc_id = aws_vpc.my_vpc.id
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [aws_subnet.private-sn.id]
  security_group_ids = [aws_security_group.endpoints-sg.id]
  tags = {
    "Name" = "ec2Messages-endpoint"
  }

  
}

resource "aws_iam_role" "ec2managedInstanceSSMRole" {
  name = "SSMmanagedInstancesRole"
  description = "Role for managed instances with SSM"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  
}

resource "aws_iam_instance_profile" "managedInstancesProfile" {
  name = "managedInstancesProfile"
  role = aws_iam_role.ec2managedInstanceSSMRole.name

  
}

data "aws_ami" "instance_ami" {
  # executable_users = ["self"]
  most_recent      = true
  # name_regex       = "^Amazon Linux 2 AMI"
  owners           = ["amazon"]

  # filter {
  #   name = "architecture"
  #   values = ["x86_64"]
  # }

  # filter {
  #   name   = "root-device-type"
  #   values = ["ebs"]
  # }

  # filter {
  #   name   = "virtualization-type"
  #   values = ["hvm"]
  # }

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2",]
  }
}

resource "aws_instance" "managedInstance" {
  ami = data.aws_ami.instance_ami.id
  availability_zone = var.az
  subnet_id = aws_subnet.private-sn.id
  vpc_security_group_ids = [aws_security_group.managed-instance-sg.id]
  associate_public_ip_address = false
  iam_instance_profile = aws_iam_instance_profile.managedInstancesProfile.name
  instance_type = var.instance_type
  tags = {
    "Name" = "managed-instance-1"
  }
}

output "ami" {
  value = data.aws_ami.instance_ami
}