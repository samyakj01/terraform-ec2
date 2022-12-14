# Creating a VPC
resource "aws_vpc" "custom" {
  cidr_block = "192.168.0.0/16"
  # Enabling automatic hostname assigning
  enable_dns_hostnames = true
  tags = {
    Name = var.tags["VpcName"]
  }
}

# Creating Public subnet
resource "aws_subnet" "subnet1" {
  depends_on = [
    aws_vpc.custom
  ]
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "192.168.0.0/24"
  availability_zone = var.availability_zone
  # Enabling automatic public IP assignment on instance launch
  map_public_ip_on_launch = var.public-ip
  tags = {
    Name = var.tags["SubName"]
  }
}

# Creating an Internet Gateway for the VPC
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1
  ]
  # VPC in which it has to be created
  vpc_id = aws_vpc.custom.id
  tags = {
    Name = var.tags["IGName"]
  }
}

# Creating an Route Table for the public subnet
resource "aws_route_table" "Public-Subnet-RT" {
  depends_on = [
    aws_vpc.custom,
    aws_internet_gateway.Internet_Gateway
  ]
  vpc_id = aws_vpc.custom.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }
  tags = {
    Name = var.tags["RTName"]
  }
}

# Creating a resource for the Route Table Association!
resource "aws_route_table_association" "RT-IG-Association" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_route_table.Public-Subnet-RT
  ]
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.Public-Subnet-RT.id
}

# Creating a Security Group for EC2 instance
resource "aws_security_group" "EC2-SG" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1
  ]
  name        = "ec2-sg"
  description = "allow SSH"
  vpc_id      = aws_vpc.custom.id

  # Inbound rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tags["SGName"]
  }
}

# Creating an AWS EC2 instance
resource "aws_instance" "myinstance" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_security_group.EC2-SG
  ]
  ami            = var.instance-ami
  instance_type  = var.instance_type
  cpu_core_count = var.cpu_core_count
  subnet_id      = aws_subnet.subnet1.id
  #Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet.
  ipv6_address_count = var.ipv6_address_count
  #Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface
  ipv6_addresses         = var.ipv6_addresses
  vpc_security_group_ids = [aws_security_group.EC2-SG.id]
  tags = {
    Name = var.tags["EC2Name"]
  }
}