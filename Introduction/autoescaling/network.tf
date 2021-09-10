resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}


resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "Main"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "Main"
  }
}


# IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}


# routes
resource "aws_route_table" "my_table_a" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}



# RT associations

resource "aws_route_table_association" "rta-subneta" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.my_table_a.id
}

# RT associations

resource "aws_route_table_association" "rta-subnetb" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.my_table_a.id
}