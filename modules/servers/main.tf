data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] 
}

# resource "aws_instance" "app_server_heating" {

#   instance_type               = var.instance_type
#   ami                         = data.aws_ami.ubuntu.id
#   associate_public_ip_address = true

#   subnet_id                   = var.public_subnets[0]
#   vpc_security_group_ids      = var.security_group_ids

#   key_name = var.key_name

#   tags = {
#     Name = "server_heating"
#   }
# }
# resource "aws_instance" "app_server_lighting" {

#   instance_type               = var.instance_type
#   ami                         = data.aws_ami.ubuntu.id
#   associate_public_ip_address = true

#   subnet_id                   = var.public_subnets[1]
#   vpc_security_group_ids      = var.security_group_ids

#   key_name = var.key_name

#   tags = {
#     Name = "server_lighting"
#   }

# }

# resource "aws_instance" "app_server_status" {

#   instance_type               = var.instance_type
#   ami                         = data.aws_ami.ubuntu.id
#   associate_public_ip_address = true

#   subnet_id                   = var.public_subnets[2]
#   vpc_security_group_ids      = var.security_group_ids

#   key_name = var.key_name

#   tags = {
#     Name = "server_status"
#   }

# }

# resource "aws_instance" "app_server_auth" {

#   instance_type               = var.instance_type
#   ami                         = data.aws_ami.ubuntu.id

#   subnet_id                   = var.private_subnets[0]
#   vpc_security_group_ids      = var.security_group_ids

#   key_name = var.key_name

#   tags = {
#     Name = "server_auth"
#   }

# }

resource "aws_instance" "app_server_bastion" {

  instance_type               = var.instance_type
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true

  subnet_id                   = var.public_subnets[0]
  vpc_security_group_ids      = var.security_group_ids

  key_name = var.key_name

  tags = {
    Name = "server_bastion"
  }
}
