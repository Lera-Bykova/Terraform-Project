variable "security_group_ids" {
    type = list(string)
}
variable "public_subnets_ids" {
    type = list(string)
}

variable "private_subnets_ids" {
    type = list(string)
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}
variable "availability_zones" {
    type = list(string)
}
variable "public_image_ids" {
  type = list(string)
}
variable "private_image_ids" {
  type = list(string)
}
variable "private_template_names" {
  type = list(string)
}
variable "public_template_names" {
  type = list(string)
}