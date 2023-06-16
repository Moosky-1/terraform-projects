#store the terraform state file in s3

terraform {
  backend "s3" {
    bucket = "april28081993demo"
    key = "three-tier/backend/moosky-website-ecs.tfstate"
    region = "eu-west-1"
    profile = "default"
  }
}