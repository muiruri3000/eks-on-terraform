# routing table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.k8svpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.k8s-nat.id
    }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.k8svpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.k8svpc-igw.id
    }

  tags = {
    Name = "public"
  }
}


# routing table association

resource "aws_route_table_association" "private-eu-north-1a" {
  subnet_id      = aws_subnet.private-eu-north-1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-eu-north-1b" {
  subnet_id      = aws_subnet.private-eu-north-1b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public-eu-north-1a" {
  subnet_id      = aws_subnet.public-eu-north-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-eu-north-1b" {
  subnet_id      = aws_subnet.public-eu-north-1b.id
  route_table_id = aws_route_table.public.id
}
