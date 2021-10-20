resource "aws_vpc" "example-vpc" {
  cidr_block = var.vpc-cidr

  tags = {
      Name = "demo"
    }
}

resource "aws_subnet" "example-sub" {
  vpc_id     = aws_vpc.example-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "demo"
  }
}

resource "aws_internet_gateway" "example-gw" {
  vpc_id = aws_vpc.example-vpc.id

  tags = {
    Name = "demo"
  }
}

resource "aws_route_table" "example-rt" {
  vpc_id = aws_vpc.example-vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.example-gw.id
    }

  route {
      ipv6_cidr_block        = "::/0"
      gateway_id = aws_internet_gateway.example-gw.id
    }

  tags = {
    Name = "demo"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.example-vpc.id

  ingress = [
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.example-vpc.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.example-vpc.ipv6_cidr_block]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  egress = [
    {
      description      = "egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "demo"
  }
}