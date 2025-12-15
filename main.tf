############################################
# VPC
############################################
resource "aws_vpc" "cloud_autopilot" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "cloud-autopilot-vpc"
    Project = var.project
  }
}

############################################
# INTERNET GATEWAY
############################################
resource "aws_internet_gateway" "cloud_autopilot" {
  vpc_id = aws_vpc.cloud_autopilot.id

  tags = {
    Name    = "cloud-autopilot-igw"
    Project = var.project
  }
}

############################################
# PUBLIC SUBNET A (us-east-2a)
############################################
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.cloud_autopilot.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "cloud-autopilot-public-subnet"
    Project = var.project
  }
}

############################################
# PUBLIC SUBNET B (us-east-2b)
############################################
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.cloud_autopilot.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "cloud-autopilot-public-subnet-b"
    Project = var.project
  }
}

############################################
# PRIVATE SUBNET A (us-east-2a)
############################################
resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.cloud_autopilot.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = false

  tags = {
    Name    = "cloud-autopilot-private-subnet"
    Project = var.project
  }
}

############################################
# NAT ELASTIC IP
############################################
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name    = "cloud-autopilot-nat-eip"
    Project = var.project
  }
}

############################################
# NAT GATEWAY (PUBLIC SUBNET A)
############################################
resource "aws_nat_gateway" "cloud_autopilot" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name    = "cloud-autopilot-nat"
    Project = var.project
  }
}
############################################
# PUBLIC ROUTE TABLE (IGW)
############################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.cloud_autopilot.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloud_autopilot.id
  }

  tags = {
    Name    = "cloud-autopilot-public-rt"
    Project = var.project
  }
}
############################################
# PRIVATE ROUTE TABLE (NAT)
############################################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.cloud_autopilot.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.cloud_autopilot.id
  }

  tags = {
    Name    = "cloud-autopilot-private-rt"
    Project = var.project
  }
}

############################################
# ROUTE TABLE ASSOCIATION
# (ONLY PRIVATE SUBNET IS MANAGED BY TF)
############################################
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}