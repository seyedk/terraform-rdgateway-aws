region            = "us-east-1"
ad_directory_type = "SimpleAD"
ad_domain_fqdn    = "ocsd.ad"
ad_admin_password = "!!Race2Win!!"
# The ID of your VPC or the ID of the VPC created in previous step 
vpc_id            = "vpc-064d3a689c8528057"

# Comma separated list of private subnet IDs that the domain controllers will be deployed in. 
# List must be enclosed in square brackets i.e. ["subnet-0011","subnet-2233"]. 
#If you do not have a VPC get the IDs of the private subnets created in step 2, from the Outputs section.
subnet_ids        = ["subnet-0b292ae9144177c04","subnet-0a89cde195117c08e",]
