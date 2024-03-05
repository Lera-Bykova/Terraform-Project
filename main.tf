module "networking" {
    source = "./modules/networking"
    cidr_block = "10.0.0.0/16"
    vpc_name = "project_vpc"
    availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
    private_subnets_cidr = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
    public_subnets_cidr  = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
}

module "security" {
    source = "./modules/security"
    vpc_id = module.networking.vpc_id
}

module "dynamo" {
    source = "./modules/dynamo"
    table_name = ["dynamo_table_heating", "dynamo_table_lighting"]
    hash_key = "id"
    hash_key_type = "N"
  
}

module "servers" {
  source = "./modules/servers"
  instance_type      = var.instance_type
  security_group_ids = module.security.security_group_ids
  public_subnets     = module.networking.public_subnets
  private_subnets = module.networking.private_subnets
  
  }


