variable "vpc_name" {
  default = "TCS-Prod"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet1_cidr" {
  default = "172.16.0.0/26"
}

variable "subnet1_name" {
  default = "prod-wed-subnet-1"
}

variable "IGW_name" {
  default = "tcs_igw"
}

variable "RT_name" {
  default = "tcs_RT"
}

variable "Route_path" {
  default = "0.0.0.0/0"
}

#aws ec2 instance variable
variable "EC2_count" {
  default = "3"
}
# EC2 image id
variable "EC2_image_id" {
  default = "ami-01bc990364452ab3e"
}
# key Name
variable "Key_name" {
  default = "ubuntu"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "EC2_name" {
  default = "DB-server0"
}

variable "project_name" {
  default = "TCS"
}
