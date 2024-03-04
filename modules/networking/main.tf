# VPC
resource "aws_vpc" "project_vpc" {
  cidr_block = var.cidr_block
    tags = {
    Name = var.vpc_name
  }
}

# Subnets
resource "aws_subnet" "public" {
  count = 3
  vpc_id = aws_vpc.project_vpc.id
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true
  cidr_block = var.public_subnets_cidr[count.index]
  tags = {
    Name = "project-subnet-public${count.index}-${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count = 3
  vpc_id = aws_vpc.project_vpc.id
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = false
  cidr_block = var.private_subnets_cidr[count.index]
  tags = {
    Name = "project-subnet-private${count.index}-${var.availability_zones[count.index]}"
  }
}
# Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    Name = "internet_gateway"
  }
}

# Nat gateways
resource "aws_nat_gateway" "project_nat" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private[0].id
}

# Route Tables
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route_table_public"
  }
}
resource "aws_route_table" "route_table_private" {
    count = 3
    vpc_id = aws_vpc.project_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.project_nat.id
    }

      tags = {
    Name = "route_table_private${count.index}"
  }

}

# Route Tables Associations
resource "aws_route_table_association" "public" {
    count = 3
    subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "private" {
    count = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.route_table_private[count.index].id
}
