#VPC
resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}


# IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "main"
  }
}

# routes
resource "aws_route_table" "my_table_a" {
  vpc_id = aws_vpc.myvpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}


# NCAL

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.myvpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  tags = {
      Name = "Main"
  }

  subnet_ids = [
      aws_subnet.subneta.id
  ]
}




# subnets

resource "aws_subnet" "subneta" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}


# RT associations

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subneta.id
  route_table_id = aws_route_table.my_table_a.id
}