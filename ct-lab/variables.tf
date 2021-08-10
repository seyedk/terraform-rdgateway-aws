#----------------------------------------------------------------------------
# REQUIRED PARAMETERS: You must provide a value for each of these parameters.
#----------------------------------------------------------------------------

variable "region" {
  description = "AWS Region"
  type        = string
  default = "us-east-1"
}

#---------------------------------------------------------------
# OPTIONAL PARAMETERS: These parameters have resonable defaults.
#---------------------------------------------------------------

variable "environment" {
  description = "Environment i.e. dev, test, stage, prod"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "172.16.0.0/16"
}

#----------------------------------------------------------------------------
# REQUIRED PARAMETERS: You must provide a value for each of these parameters.
#----------------------------------------------------------------------------


variable "ad_directory_type" {
  description = "What type of directory: SimpleAD or MicrosoftAD?"
  type        = string
  default     = "SimpleAD"

  validation {
    condition     = var.ad_directory_type == "SimpleAD" || var.ad_directory_type == "MicrosoftAD"
    error_message = "The directory type must be either SimpleAD or MicrosoftAD."
  }
}

variable "ad_domain_fqdn" {
  description = "The  fully qualified domain name of the AD domain, i.e. example.com"
  type        = string
  default     = "pbp.com"
}

variable "ad_admin_password" {
  description = "The  password for the admin/administrator account"
  type        = string
  default     = "AFASDFASDFASDFASDFASDFowier2039840298340"
}

variable "vpc_id" {
  description = "The ID of the VPC the AD directory will be deployed in"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "The list of private subnet IDs that the domain controllers will be deployed in"
  type        = list(string)
  default     = null
}

#----------------------------------------------------------------------------
# REQUIRED PARAMETERS: You must provide a value for each of these parameters.
#----------------------------------------------------------------------------


variable "route53_public_zone" {
  description = "The name of the public Route 53 zone (aka domain name) that Letsencrypt certificates are issued for"
  type        = string
  default     = "pacificbluepine.com"
}

# variable "certbot_zip" {
#   description = "The name of the certbot zip artifact to use i.e. certbot-0.27.1.zip"
#   type        = string
# }

#---------------------------------------------------------------
# OPTIONAL PARAMETERS: These parameters have resonable defaults.
#---------------------------------------------------------------

# variable "environment" {
#   description = "Environment i.e. dev, test, stage, prod"
#   type        = string
#   default     = "dev"
# }

variable "s3_prefix" {
  description = "Prefix to use for the S3 bucket name"
  type        = string
  default     = "letsencrypt-certbot-lambda"
}

# variable "subdomain_name" {
#   description = "The name of the subdomain if applicable i.e. ops"
#   type        = string
#   default     = null
# }

variable "email" {
  description = "The email address that Letsencrypt sends notifications to"
  type        = string
  default     = "seyed.ketabchi@gmail.com"
}

variable "windows_target" {
  description = "Set to true if the tls certificate will be installed on a Windows machine"
  type        = bool
  default     = true
}

#----------------------------------------------------------------------------
# REQUIRED PARAMETERS: You must provide a value for each of these parameters.
#----------------------------------------------------------------------------


variable "key_name" {
  description = "The name of the key pair that allows to securely connect to the instance after launch"
  type        = string
  default     = "karla-dennis"
}

# variable "public_subnet_id" {
#   description = "The  ID of a public subnet in the VPC where the RD Gateway will be deployed"
#   type        = string
# }

# variable "s3_bucket" {
#   description = "The name of the S3 bucket that contains the scripts to be installed on the EC2 instance"
#   type        = string
# }

# variable "s3_bucket_tls" {
#   description = "The name of the bucket that the certbot Lambda function deposits the TLS certificates in"
#   type        = string
# }

# variable "s3_folder_tls" {
#   description = "The name of the S3 folder where the TLS certificates are deposited by the certbot Lambda"
#   type        = string
# }

# variable "sqs_url" {
#   description = "The URL of the SQS Queue that receives notification from S3 when new certificates arrive."
#   type        = string
# }

#---------------------------------------------------------------
# OPTIONAL PARAMETERS: These parameters have resonable defaults.
#---------------------------------------------------------------


variable "rdgw_instance_type" {
  description = "The EC2 instance type for the RD Gateway"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "The ID of the AWS EC2 AMI to use (if null the latest Windows Server 2019 is selected)"
  type        = string
  default     = null
}

variable "rdgw_allowed_cidr" {
  description = "The allowed CIDR IP range for RDP access to the RD Gateway"
  type        = string
  default     = "0.0.0.0/0"

}

variable "rdgw_name" {
  description = "The name of the RD Gateway instance"
  type        = string
  default     = "rdgateway"
}




variable "scripts" {
  description = "The scripts in the S3 bucket to be downloaded on the EC2 instance"
  type        = map(string)
  default = {
    "create_task" = "/scripts/create-scheduled-task.ps1"
    "renew_tls"   = "/scripts/renew-letsencrypt-tls.ps1"
    "get_tls"     = "/scripts/get-latest-letsencrypt-tls.ps1"
  }
}

variable "ad_directory_id" {
  description = "The ID of the AD domain (if null the RD Gateway will NOT be joined to domain)"
  type        = string
  default     = null
  
}

variable "ad_dns_ips" {
  description = "The IPs of the DNS servers for the AD domain"
  type        = list(string)
  default     = null
  
}


variable "sns_arn" {
  description = "The ARN of an SNS topic to receive notifications of TLS certificate renewal (if null new SNS topic will be created)"
  type        = string
  default     = null
}

variable "certbot_zip" {
  description = "The name of the certbot zip artifact to use i.e. certbot-0.27.1.zip"
  type        = string
  default     = "certbot-0.27.1.zip"
}