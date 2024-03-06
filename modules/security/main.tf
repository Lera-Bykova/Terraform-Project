data "http" "myipaddr" {
   url = "http://icanhazip.com"
}

# HTTP ports 80 and 3000
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.allow_http.id
}

resource "aws_security_group_rule" "allow_http_3000" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.allow_http.id
}


# HTTPS ports 80 and 3000
resource "aws_security_group" "allow_https" {
  name        = "allow_https"
  description = "Allow https inbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.allow_https.id
}


# SSH port 22
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ssh" {
  type = "ingress"
  from_port   = 22
  to_port     = 22
  protocol = "tcp"
  cidr_blocks = ["${chomp(data.http.myipaddr.response_body)}/32","10.0.0.0/16"]
  security_group_id = aws_security_group.allow_ssh.id
}

# EGRESS

resource "aws_security_group" "allow_egress" {
  name        = "allow_egress"
  description = "Allow egress inbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.allow_egress.id
}

# BASTION HOST?
# resource "aws_security_group" "allow_ssh_bastion" {
#   name        = "allow_ssh_bastion"
#   description = "Allow ssh inbound traffic"
#   vpc_id      = var.vpc_id
# }
# resource "aws_security_group_rule" "ssh" {
#   type = "ingress"
#   from_port   = 22
#   to_port     = 22
#   protocol = "tcp"
#   cidr_blocks = ["${chomp(data.http.myipaddr.response_body)}/32"]
#   security_group_id = aws_security_group.allow_ssh.id
#   source_security_group_id = aws_security_group.allow_ssh
# }