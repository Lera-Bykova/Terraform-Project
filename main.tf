module "networking" {
    source = "./modules/networking"
    cidr_block = "10.0.0.0/16"
    vpc_name = "project_vpc"
    availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
    private_subnets_cidr = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
    public_subnets_cidr  = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
}

# module "security" {
#     source = "./modules/security"
#     vpc_id = module.networking.vpc_id
  
# }

