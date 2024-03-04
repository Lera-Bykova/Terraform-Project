output "vpc_name" {
    value = module.networking.vpc_name
}
output "vpc_id" {
  value = module.networking.vpc_id
}
output "public_subnets" {
    value = module.networking.public_subnets
}