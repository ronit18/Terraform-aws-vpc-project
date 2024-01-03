resource "aws_instance" "aws_terraform_ec2-public" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"
  key_name      = "ap-south-1"

  vpc_security_group_ids      = [aws_security_group.aws_terraform_ec2_sg.id]
  subnet_id                   = aws_subnet.aws_terraform_vpc_subnet-public.id
  associate_public_ip_address = true

  tags = {
    Name = "aws_terraform_ec2-public"
  }
}
resource "aws_instance" "aws_terraform_ec2-private" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"
  key_name      = "ap-south-1"

  vpc_security_group_ids = [aws_security_group.aws_terraform_ec2_sg.id]
  subnet_id              = aws_subnet.aws_terraform_vpc_subnet-private.id

  tags = {
    Name = "aws_terraform_ec2-private"
  }
}

resource "aws_security_group" "aws_terraform_ec2_sg" {
  name        = "aws_terraform_ec2_sg"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.aws_terraform_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
