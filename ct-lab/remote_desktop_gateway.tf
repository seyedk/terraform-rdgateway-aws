
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    #   version = "~> 3.22.0"
    }
  }
  required_version = ">= 0.13"
}

module "rdgw_vpc" {
    source  = "../modules/vpc"
    region = var.region
    environment = var.environment
    vpc_cidr = var.vpc_cidr

}

locals {

    vpc_id = var.vpc_id != null ? var.vpc_id: module.rdgw_vpc.vpc_id
    subnet_ids = var.subnet_ids != null ? var.subnet_ids: module.rdgw_vpc.private_subnets
    ad_directory_id = var.ad_directory_id !=null ? var.ad_directory_id: module.rdgw_active_directory.ad_directory_id
    ad_dns_ips= var.ad_dns_ips!=null? var.ad_dns_ips: module.rdgw_active_directory.ad_dns_ips



}

module "rdgw_active_directory" {

    source  = "../modules/ad"
    region = var.region
    ad_directory_type = var.ad_directory_type
    ad_domain_fqdn = var.ad_domain_fqdn

    ad_admin_password = var.ad_admin_password
    # vpc_id = module.rdgw_vpc.vpc_id
    vpc_id = local.vpc_id

    # subnet_ids = module.rdgw_vpc.private_subnets

    subnet_ids = local.subnet_ids

}

module "rdgw_letsencrypt_tls" {
    source = "../modules/letsencrypt-tls"
    region = var.region
    route53_public_zone = var.route53_public_zone
    certbot_zip = var.certbot_zip
}

module "rd_gateway" {
    source  = "../modules/rd-gateway"

    public_subnet_id = module.rdgw_vpc.public_subnets[0]
    key_name = var.key_name
    region = var.region
    s3_bucket= module.rdgw_letsencrypt_tls.s3_bucket_certbot
    s3_bucket_tls=module.rdgw_letsencrypt_tls.s3_bucket_tls
    s3_folder_tls=module.rdgw_letsencrypt_tls.s3_folder_tls


    ad_directory_id =  local.ad_directory_id
    ad_dns_ips = local.ad_dns_ips  

    sqs_url= module.rdgw_letsencrypt_tls.sqs_url
    route53_public_zone=var.route53_public_zone
    rdgw_allowed_cidr=var.rdgw_allowed_cidr
    ad_domain_fqdn = var.ad_domain_fqdn

}
