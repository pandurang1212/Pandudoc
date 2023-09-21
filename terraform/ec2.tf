resource "aws_ami_copy" "web" {
  name              = "terraform-example-web"
  description       = "A copy of ami-web"
  source_ami_id     = "ami-03a6eaae9938c858c"
  instance_type     = "t2.micro"
  source_ami_region = "us-west-1"

  tags = {
    Name = "HelloWorld"
  }
}