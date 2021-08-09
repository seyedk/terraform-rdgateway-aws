# Deploys a Simple or Managed Microsoft directory in AWS Directory Service.


provider "aws" {
  region = var.region
}

locals {
  simple_ad_count  = var.ad_directory_type == "SimpleAD" ? 1 : 0
  ms_ad_count      = var.ad_directory_type == "SimpleAD" ? 0 : 1
  directory_id     = var.ad_directory_type == "SimpleAD" ? aws_directory_service_directory.simple_ad[0].id : aws_directory_service_directory.microsoft_ad[0].id
  dns_ip_addresses = var.ad_directory_type == "SimpleAD" ? aws_directory_service_directory.simple_ad[0].dns_ip_addresses : aws_directory_service_directory.microsoft_ad[0].dns_ip_addresses
}

data "terraform_remote_state" "vpc" {

  backend = "s3"

  config = {
    bucket         = "xceclerator-building-blocks-seyedk"
    key            = "rdgw-vpc/terraform.tfstate"
    region         = "us-east-1"

  }
}

# Create a MicrosoftAD directory if var.ad_directory_type == "MicrosoftAD"
resource "aws_directory_service_directory" "microsoft_ad" {
  count = local.ms_ad_count

  name     = var.ad_domain_fqdn
  password = var.ad_admin_password

  type    = var.ad_directory_type
  edition = "Standard"

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids
  }
  # vpc_settings {
  #   vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  #   subnet_ids  = data.terraform_remote_state.vpc.outputs.private_subnets
  # }
  tags = {
    terraform = "true"
  }
}

# Create a SimpleAD directory if var.ad_directory_type == "SimpleAD"
resource "aws_directory_service_directory" "simple_ad" {
  count = local.simple_ad_count

  name     = var.ad_domain_fqdn
  password = var.ad_admin_password

  type = var.ad_directory_type
  size = "Small"

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids
  }
  # vpc_settings {
  #   vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  #   subnet_ids  = data.terraform_remote_state.vpc.outputs.private_subnets
  # }

  tags = {
    terraform = "true"
  }
}
