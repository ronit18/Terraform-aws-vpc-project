
resource "aws_vpc" "aws_terraform_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "aws_terraform_vpc_subnet-public" {
  vpc_id            = aws_vpc.aws_terraform_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "aws_terraform_vpc_subnet-public"
  }
}

resource "aws_subnet" "aws_terraform_vpc_subnet-private" {
  vpc_id            = aws_vpc.aws_terraform_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "aws_terraform_vpc_subnet-private"
  }
}
resource "aws_internet_gateway" "aws_terraform_vpc_igw" {
  vpc_id = aws_vpc.aws_terraform_vpc.id

  tags = {
    Name = "aws_terraform_vpc_igw"
  }
}

resource "aws_route_table" "aws_terraform_vpc_public_rt" {
  vpc_id = aws_vpc.aws_terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_terraform_vpc_igw.id
  }

  tags = {
    Name = "aws_terraform_vpc_public_rt"
  }


}
resource "aws_route_table_association" "aws_terraform_vpc_public_rta" {
  subnet_id      = aws_subnet.aws_terraform_vpc_subnet-public.id
  route_table_id = aws_route_table.aws_terraform_vpc_public_rt.id

}
resource "aws_eip" "aws_terraform_vpc_eip" {
  domain = "vpc"

  tags = {
    Name = "aws_terraform_vpc_eip"
  }

  depends_on = [aws_internet_gateway.aws_terraform_vpc_igw]
}
resource "aws_nat_gateway" "aws_terraform_vpc_nat_gw" {
  allocation_id = aws_eip.aws_terraform_vpc_eip.id
  subnet_id     = aws_subnet.aws_terraform_vpc_subnet-public.id

  tags = {
    Name = "aws_terraform_vpc_nat_gw"
  }
}

resource "aws_route_table" "aws_terraform_vpc_private_rt" {
  vpc_id = aws_vpc.aws_terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.aws_terraform_vpc_nat_gw.id
  }

  tags = {
    Name = "aws_terraform_vpc_private_rt"
  }
}
resource "aws_route_table_association" "aws_terraform_vpc_private_rta" {
  subnet_id      = aws_subnet.aws_terraform_vpc_subnet-private.id
  route_table_id = aws_route_table.aws_terraform_vpc_private_rt.id
}
