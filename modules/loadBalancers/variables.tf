variable "public_subnets" {
    type = list(string)
  
}
variable "private_subnets" {
    type = list(string)
  
}
variable "security_groups" {
    type = list(string)
  
}
variable "vpc_id" {
    type = string
  
}
variable "auth_instance_id" {
  type = string
}

variable "lighting_instance_id" {
  type = string
}
variable "heating_instance_id" {
  type = string
}
variable "status_instance_id" {
  type = string
}
