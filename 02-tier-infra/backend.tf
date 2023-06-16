terraform {

  backend "s3" {

    bucket = "april28081993demo"
    key    = "three-tier/backend"
    region = "eu-west-1"
  }

}