# terraform Provider details

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Create a VPC
resource "aws_vpc" "test_vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test_vpc1"
    env  = "Prod-env"
  }
}

# Subnet creation
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.test_vpc1.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet1"
  }
}

# creating IGW 
resource "aws_internet_gateway" "IGW1" {
  vpc_id = aws_vpc.test_vpc1.id
  tags = {
    Name = "test-igw"
  }
}

# creating route table 
resource "aws_route_table" "RT1" {
  vpc_id = aws_vpc.test_vpc1.id
  tags = {
    Name = "public-RT"
  }
}

# subnet association 
resource "aws_route_table_association" "SA1" {
  route_table_id = aws_route_table.RT1.id
  subnet_id      = aws_subnet.subnet1.id
}

# route table association
resource "aws_route" "route1" {
  route_table_id         = aws_route_table.RT1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW1.id
}

# creating the instance in the vpc 
resource "aws_instance" "server1" {
  count = 3
  ami = "ami-01bc990364452ab3e"
  key_name = "ubuntu"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id
  associate_public_ip_address = true
  
  tags = {
    Name = "DB-server0${count.index+1}"
    Env = "Prod0${count.index+1}"
  }
}
