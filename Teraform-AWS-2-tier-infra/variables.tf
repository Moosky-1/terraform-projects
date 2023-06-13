#--- root/variables.tf ----

variable "aws_region" {
  default = "eu-west-1"
}

variable "access_ip" {
  type    = string
  default = "0.0.0.0/0"
}