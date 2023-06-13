terraform  {

    backend "s3"   {

        bucket  = "april28081993demo"
        key     = "moosky/tf-backend"
        region  = "eu-west-1"
    }
    
}