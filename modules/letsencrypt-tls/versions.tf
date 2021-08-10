# terraform {
#   backend "s3" {
#     bucket         = "xceclerator-building-blocks-seyedk"
#     key            = "rdgw-tls/terraform.tfstate"
#     region         = "us-east-1"
#   }
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.22.0"
#     }
#   }
#   required_version = ">= 0.13"
# }
