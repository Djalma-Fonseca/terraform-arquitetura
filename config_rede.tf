# Criando vpc
resource "aws_vpc" "vpc-lab" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
      Name = "Vpc lab"
  }
}

# Criando subnets pública e privada

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.vpc-lab.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-pub-1"
  }
}


resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.vpc-lab.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "subnet-pub-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.vpc-lab.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  
  
  tags = {
    Name = "subnet-priv-1"
  }

}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.vpc-lab.id
  cidr_block = "10.0.8.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "subnet-priv-2"
  }
}

# Criando o internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-lab.id

  tags = {
    Name = "lab_teste"
  }
}

# Criando um nat gateway

resource "aws_eip" "nat" {
  vpc = true
}

 resource  "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.private_subnet_1.id

}

 resource "aws_route_table" "router" {
  vpc_id = aws_vpc.vpc-lab.id
  tags = {
    Name = "Rota djalma"
  }

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
}

 resource "aws_route_table_association" "assoc" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.router.id
}   