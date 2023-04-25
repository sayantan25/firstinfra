locals {
  azs = data.aws_availability_zones.available.names
}

data "aws_availability_zones" "available" {

}

resource "random_id" "random" {
  byte_length = 2
}



resource "aws_vpc" "saya_vpc" {
  #cidr_block = "10.123.0.0/16"
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "saya_vpc-${random_id.random.dec}"
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_internet_gateway" "saya_igw" {

  vpc_id = aws_vpc.saya_vpc.id

  tags = {
    Name = "saya_igw-${random_id.random.dec}"
  }
}

resource "aws_route_table" "saya_rt_igw" {
  vpc_id = aws_vpc.saya_vpc.id

  tags = {
    Name = "saya_rt_igw"
  }
}

resource "aws_route" "default_route" {

  route_table_id         = aws_route_table.saya_rt_igw.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.saya_igw.id


}

resource "aws_default_route_table" "saya_private_rt" {

  default_route_table_id = aws_vpc.saya_vpc.default_route_table_id

  tags = {
    Name = "saya_private_rt"
  }

}

resource "aws_subnet" "saya_public_subnet" {

  count = length(local.azs)

  vpc_id                  = aws_vpc.saya_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = local.azs[count.index]

  tags = {
    Name = "saya_public_subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "saya_private_subnet" {

  count = length(local.azs)

  vpc_id                  = aws_vpc.saya_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, length(local.azs) + count.index)
  map_public_ip_on_launch = false
  availability_zone       = local.azs[count.index]

  tags = {
    Name = "saya_private_subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "saya_public_assoc" {
  count          = length(local.azs)
  subnet_id      = aws_subnet.saya_public_subnet[count.index].id
  route_table_id = aws_route_table.saya_rt_igw.id
}

resource "aws_security_group" "saya_sg" {
  name        = "public_sg"
  description = "security group for public instances"
  vpc_id      = aws_vpc.saya_vpc.id
}


resource "aws_security_group_rule" "ingress_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = [var.access_ip, var.cloud9_ip]
  security_group_id = aws_security_group.saya_sg.id
}


resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.saya_sg.id
}

























































