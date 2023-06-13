terraform {

  backend "s3" {

    bucket = "april28081993demo"
    key    = "liontech-infra/backend"
    region = "eu-west-1"
  }

}