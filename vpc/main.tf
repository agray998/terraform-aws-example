resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = {
      Name = "demo"
    }
}

resource "aws_subnet" "example_sub" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
  tags                    = {
    Name = "demo"
  }
}

resource "aws_internet_gateway" "example_gw" {
  vpc_id = aws_vpc.example_vpc.id
  tags   = {
    Name = "demo"
  }
}

resource "aws_route_table" "example_rt" {
  vpc_id = aws_vpc.example_vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.example_gw.id
    }

  route {
      ipv6_cidr_block = "::/0"
      gateway_id      = aws_internet_gateway.example_gw.id
    }
  tags = {
    Name = "demo"
  }
}

resource "aws_route_table_association" "example_rta" {
  subnet_id      = aws_subnet.example_sub.id
  route_table_id = aws_route_table.example_rt.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.example_vpc.id

  ingress = [
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Flask"
      from_port        = 5000
      to_port          = 5000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
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
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "demo"
  }
}