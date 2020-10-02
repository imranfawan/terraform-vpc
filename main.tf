provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

#***************** Define the public subnets in each az ***********************************   kubernetes.io/role/elb = 1
resource "aws_subnet" "public-subnet-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr_1
  availability_zone = var.aws_zone_1a

  tags = {
    Name = "vpc_pub_1a"
  }
}

resource "aws_subnet" "public-subnet-1b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr_2
  availability_zone = var.aws_zone_1b

  tags = {
    Name = "vpc_pub_1b"
  }
}

resource "aws_subnet" "public-subnet-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr_3
  availability_zone = var.aws_zone_1c

  tags = {
    Name = "vpc_pub_1c"
  }
}

# ***************** Define the private subnets in each az ***********************************
resource "aws_subnet" "private-subnet-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_1
  availability_zone = var.aws_zone_1a

  tags = {
    Name = "vpc_pvt_1a"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = var.aws_zone_1b

  tags = {
    Name = "vpc_pvt_1b"
  }
}

resource "aws_subnet" "private-subnet-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_3
  availability_zone = var.aws_zone_1c

  tags = {
    Name = "vpc_pvt_1c"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "vpc-public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "vpc Public Subnet RT"
  }
}

# ********************Assign the route table to all three public Subnet ****************************
resource "aws_route_table_association" "vpc-public-rt-1a" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.vpc-public-rt.id
}

resource "aws_route_table_association" "vpc-public-rt-1b" {
  subnet_id      = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.vpc-public-rt.id
}

resource "aws_route_table_association" "vpc-public-rt-1c" {
  subnet_id      = aws_subnet.public-subnet-1c.id
  route_table_id = aws_route_table.vpc-public-rt.id
}

# ********************Create three EIPs / NATS (one for each public subnet)****************************
resource "aws_eip" "nat-eip-1a" {
  vpc = true
}

resource "aws_eip" "nat-eip-1b" {
  vpc = true
}

resource "aws_eip" "nat-eip-1c" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw-1a" {
  allocation_id = aws_eip.nat-eip-1a.id
  subnet_id     = aws_subnet.public-subnet-1a.id
  depends_on    = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat-gw-1b" {
  allocation_id = aws_eip.nat-eip-1b.id
  subnet_id     = aws_subnet.public-subnet-1b.id
  depends_on    = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat-gw-1c" {
  allocation_id = aws_eip.nat-eip-1c.id
  subnet_id     = aws_subnet.public-subnet-1c.id
  depends_on    = [aws_internet_gateway.gw]
}

# ********************Create three route tables (to be assigned to each of the three private subnets)****************************
resource "aws_route_table" "vpc-private-rt-1a" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1a.id
  }

  tags = {
    Name = "vpc pvt subnet RT (1a)"
  }
}

resource "aws_route_table" "vpc-private-rt-1b" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1b.id
  }

  tags = {
    Name = "vpc pvt subnet RT (1b)"
  }
}

resource "aws_route_table" "vpc-private-rt-1c" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1c.id
  }

  tags = {
    Name = "vpc pvt subnet RT (1c)"
  }
}

# ********************associate the private route tables to their respective pvt subnets ****************************
resource "aws_route_table_association" "vpc-private-rt-1a" {
  subnet_id      = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.vpc-private-rt-1a.id
}

resource "aws_route_table_association" "vpc-private-rt-1b" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.vpc-private-rt-1b.id
}

resource "aws_route_table_association" "vpc-private-rt-1c" {
  subnet_id      = aws_subnet.private-subnet-1c.id
  route_table_id = aws_route_table.vpc-private-rt-1c.id
}
