variable REGION {
  default = "us-east-2"
}

variable ZONE1 {
  default = "us-east-2a"
}

variable AMIS {
  type = map
  default = {
    us-east-2 = "ami-03657b56516ab7912"
    eu-west-1 = "ami-0947d2ba12ee1ff75"
  }
}