terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }

  required_version = ">= 0.15"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

###########################
# Customer managed KMS key
###########################
resource "aws_kms_key" "dev" {
  description             = "Key to protect S3 objects"
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
  is_enabled              = true
}

resource "aws_kms_alias" "dev_alias" {
  name          = "alias/s3-key"
  target_key_id = aws_kms_key.dev.key_id
}

########################
# Bucket creation
########################
resource "aws_s3_bucket" "april28081993demo" {
  bucket = var.bucket_name
}

##########################
# Bucket private access
##########################
resource "aws_s3_bucket_acl" "april28081993demo_acl" {
  bucket = aws_s3_bucket.april28081993demo.id
  acl    = "private"
}

#############################
# Enable bucket versioning
#############################
resource "aws_s3_bucket_versioning" "april28081993demo_versioning" {
  bucket = aws_s3_bucket.april28081993demo.id
  versioning_configuration {
    status = "Enabled"
  }
}

##########################################
# Enable default Server Side Encryption
##########################################
resource "aws_s3_bucket_server_side_encryption_configuration" "april28081993demo_server_side_encryption" {
  bucket = aws_s3_bucket.april28081993demo.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.dev.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

############################
# Creating Lifecycle Rule
############################
resource "aws_s3_bucket_lifecycle_configuration" "april28081993demo_lifecycle_rule" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.april28081993demo_versioning]

  bucket = aws_s3_bucket.april28081993demo.bucket

  rule {
    id     = "basic_config"
    status = "Enabled"

    filter {
      prefix = "config/"
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

########################
# Disabling bucket
# public access
########################
resource "aws_s3_bucket_public_access_block" "april28081993demo_access" {
  bucket = aws_s3_bucket.april28081993demo.id

  # Block public access
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}