
resource "aws_launch_template" "Terraform-template-heating" {
  name = "Terraform-template-heating"
  image_id = "ami-061e2c1299899774e"
  instance_type = "t2.micro"
    key_name = "My Key"
  network_interfaces {
    security_groups =  var.security_group_ids
    subnet_id = var.public_subnets_ids[0]
    associate_public_ip_address = true
  }
}

resource "aws_launch_template" "Terraform-template-lighting" {
  name = "Terraform-template-lighting"
  image_id =  "ami-0cea140a02d5d5b4e"
  instance_type = "t2.micro"
    key_name = "My Key"
  network_interfaces {
    security_groups =  var.security_group_ids
    subnet_id = var.public_subnets_ids[0]
    associate_public_ip_address = true
  }
}

resource "aws_launch_template" "Terraform-template-auth" {
  name = "Terraform-template-auth"
  image_id = "ami-06b0e499c07c40d36"
  instance_type = "t2.micro"
    key_name = "My Key"
  network_interfaces {
    security_groups =  var.security_group_ids
    subnet_id = var.private_subnets_ids[0]
    associate_public_ip_address = false
  }
}


resource "aws_launch_template" "Terraform-template-status" {
  name = "Terraform-template-status"
  image_id =  "ami-07721cc5f32990698"
  instance_type = "t2.micro"
    key_name = "My Key"
  network_interfaces {
    security_groups =  var.security_group_ids
    subnet_id = var.public_subnets_ids[0]
    associate_public_ip_address = true
  }
}




resource "aws_autoscaling_group" "Autoscaling_group_heating" {
  availability_zones = ["eu-west-2a"]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.Terraform-template-heating.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_group" "Autoscaling_group_lighting" {
  availability_zones = ["eu-west-2a"]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.Terraform-template-lighting.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "Autoscaling_group_auth" {
  availability_zones = ["eu-west-2a"]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.Terraform-template-auth.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_group" "Autoscaling_group_status" {
  availability_zones = ["eu-west-2a"]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.Terraform-template-status.id
    version = "$Latest"
  }
}