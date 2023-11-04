terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Create a VPC
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# myvpc 2
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }

}
# Subnet creation
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet1_cidr
  tags = {
    Name = "${var.subnet1_name}"

  }
}

# creating IGW 
resource "aws_internet_gateway" "IGW1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = var.IGW_name
  }
}

# creating route table 
resource "aws_route_table" "RT1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = var.RT_name
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
  destination_cidr_block = var.Route_path
  gateway_id             = aws_internet_gateway.IGW1.id
}


# creating the instance in the vpc 
resource "aws_instance" "server1" {
  count                       = var.EC2_count
  ami                         = var.EC2_image_id
  key_name                    = var.Key_name
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet1.id
  associate_public_ip_address = true
 
  tags = {
    Name = var.EC2_name

  }
}
