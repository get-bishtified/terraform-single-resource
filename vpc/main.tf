# ------------------------
# VPC with Public and Private Subnets
# ------------------------

provider "aws" {
  region = "ap-south-1"
}

# ------------------------
# VPC
# ------------------------
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "demo-vpc"
  }
}

# ------------------------
# Internet Gateway
# ------------------------
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo-igw"
  }
}

# ------------------------
# Public Subnet
# ------------------------
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

# ------------------------
# Private Subnet
# ------------------------
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-subnet-1"
  }
}

# ------------------------
# Public Route Table
# ------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# ------------------------
# Elastic IP for NAT
# ------------------------
resource "aws_eip" "demo_nat_eip" {
  depends_on = [aws_internet_gateway.demo_igw]

  tags = {
    Name = "demo-nat-eip"
  }
}

# ------------------------
# NAT Gateway
# ------------------------
resource "aws_nat_gateway" "demo_nat" {
  allocation_id = aws_eip.demo_nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "demo-nat-gw"
  }
}

# ------------------------
# Private Route Table
# ------------------------
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo_nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}
