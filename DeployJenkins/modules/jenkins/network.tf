
resource "aws_subnet" "mmo-public" {
  vpc_id = aws_vpc.mmo-vpc.id
  cidr_block = "10.10.10.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "mmo-public"
  }
}

resource "aws_internet_gateway" "mmo-gw" {
  vpc_id = aws_vpc.mmo-vpc.id
  tags = {
    Name = "mmo-gw"
  }
}

resource "aws_route_table" "TF-Route" {
  vpc_id = aws_vpc.mmo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mmo-gw.id
  }
  route {
    cidr_block = "10.10.0.0/16"
    gateway_id = "local"
  }
  tags = {
    Name = "Mmo-Routing"
  }
}

resource "aws_main_route_table_association" "mmoroute" {
  vpc_id = aws_vpc.mmo-vpc.id
  route_table_id = aws_route_table.TF-Route.id
}

resource "aws_security_group" "mmo-nsg" {
    name = "Mmo NSG"
    description = "MMo NSG"
    vpc_id = aws_vpc.mmo-vpc.id
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    ingress {
        description = "jenkins"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"
        ]
    }
  
}
