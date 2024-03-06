variable "instance_type" {
    type = string
  
}
variable "security_group_ids" {
    type = list(string)
  
}
variable "public_subnets" {
    type = list(string)
  
}
variable "private_subnets" {
    type = list(string)
  
}

variable "key_name" {
    type = string
  
}