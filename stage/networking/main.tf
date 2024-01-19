provider "aws" {
  region = "us-east-1"
}

# Getting all availability zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating vpc with ip dns service
resource "aws_vpc" "terra_pc" {
  cidr_block = "13.0.0.0/16"
  tags = {
    Name = "dev-vpc-1"
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}

# Creating subnets on every availability zones
resource "aws_subnet" "terra_nets" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.terra_pc.id
  cidr_block        = "13.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}

# Creating internet gateway
resource "aws_internet_gateway" "terra_gateway" {
  vpc_id = aws_vpc.terra_pc.id
  tags = {
    Name="dev-ig-full-app"
  }
}

# Creating route table with internet connections
resource "aws_route_table" "terra_table" {
  vpc_id = aws_vpc.terra_pc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_gateway.id
  }
  tags = {
    Name = "${aws_vpc.terra_pc.tags["Name"]} public route table"
  }
}

resource "aws_route_table_association" "terra_route_association" {
  count          = length(aws_subnet.terra_nets)
  route_table_id = aws_route_table.terra_table.id
  subnet_id      = aws_subnet.terra_nets[count.index].id
}

