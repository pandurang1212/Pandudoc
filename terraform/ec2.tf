resource "aws_ami" "web" {
  name              = "terraform-example-web"
  description       = "ami-web"
  ami               = "ami-03a6eaae9938c858c"
  instance_type     = "t2.micro"
  
  tags = {
    Name = "HelloWorld"
  }
}