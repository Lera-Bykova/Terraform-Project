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
  key_name = "My Key"
  }

module "load_balancer" {
    source = "./modules/loadBalancers"

    public_subnets = module.networking.public_subnets
    private_subnets = module.networking.private_subnets

    security_groups = module.security.security_group_ids
    vpc_id = module.networking.vpc_id

    lighting_instance_id = module.servers.lighting_instance_id
    heating_instance_id = module.servers.heating_instance_id
    auth_instance_id = module.servers.auth_instance_id
    status_instance_id = module.servers.status_instance_id

    autoscaling_group_auth_name = module.autoscaling.autoscaling_group_auth_name
    autoscaling_group_heating_name = module.autoscaling.autoscaling_group_heating_name
    autoscaling_group_lighting_name = module.autoscaling.autoscaling_group_lighting_name
    autoscaling_group_status_name = module.autoscaling.autoscaling_group_status_name
}

module "autoscaling" {
    source = "./modules/autoscaling"

    security_group_ids = module.security.security_group_ids
    public_subnets_ids = module.networking.public_subnets
    private_subnets_ids = module.networking.private_subnets
  
}