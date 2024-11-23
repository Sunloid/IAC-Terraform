terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "intro" {
  ami = var.ami
  instance_type = var.instance_type
  availability_zone = var.vpc_security_group_ids
  key_name = "Sunloid-test"
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = {
    Name = "Jenkins_Instance"
  }

  provisioner "file" {
    source = "Jenkins_Setup.sh"
    destination = "/tmp/Jenkins_Setup.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod 777 /tmp/Jenkins_Setup.sh",
        "cd /tmp", 
        "sudo Jenkins_Setup.sh"
     ]
  }
}
