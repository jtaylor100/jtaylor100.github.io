terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"

  backend "local" {}
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

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

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "macbook-pro" {
  key_name = "macbook-pro"
  public_key = file("~/.ssh/id_rsa.pub") 
}

resource "aws_security_group" "goatcounter_server" {
  name        = "goatcounter_server_sg"
  description = "Goatcounter Server Security Group"

  ingress {
    description      = "SSH"
    from_port        = 22 
    to_port          = 22 
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    description      = "HTTPS"
    from_port        = 443 
    to_port          = 443 
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80 
    to_port          = 80 
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }  
}

resource "aws_instance" "goatcounter_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.macbook-pro.key_name
  security_groups = [ aws_security_group.goatcounter_server.name ]
  user_data = templatefile("./cloud-init.yaml", { password = var.goatcounter_password })
}

output "goatcounter_url" {
  value = aws_instance.goatcounter_server.public_dns
}

variable "goatcounter_password" {
  type = string
  sensitive = true
}

