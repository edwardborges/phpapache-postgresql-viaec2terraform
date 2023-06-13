resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Defina o bloco CIDR da sua VPC

  tags = {
    Name = "minha-vpc" # Ajuste o nome da VPC aqui
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24" # Defina o bloco CIDR da sua subnet pública
  availability_zone       = "us-west-2a"  # Defina a zona de disponibilidade desejada (us-west-2a, us-west-2b, etc.)
  map_public_ip_on_launch = true

  tags = {
    Name = "minha-subnet-publica" # Ajuste o nome da subnet aqui
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
