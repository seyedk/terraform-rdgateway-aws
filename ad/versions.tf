terraform {
   backend "s3" {
    bucket         = "xceclerator-building-blocks-seyedk"
    key            = "rdgw-ad/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
  required_version = ">= 0.13"
}

