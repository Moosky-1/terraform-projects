resource "aws_instance" "liontechdev" {
  ami           = var.amis
  instance_type = "t2.micro"
}