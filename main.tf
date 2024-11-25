terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}


resource "aws_key_pair" "name" {
  key_name = "SunloidTest"
  public_key = file("id_rsa.pub")
}

resource "aws_instance" "intro" {
  for_each = var.Instance
  ami = each.value.ami
  instance_type = each.value.instance_type
  availability_zone = each.value.availability_zone
  key_name = "SunloidTest"
  vpc_security_group_ids = ["sg-0e021e9d85bb8b30c"]
  associate_public_ip_address = true  
  tags = {
    Name = each.value.Name
  }

  connection {
    host = self.public_ip
    type = "ssh"
    user = "ubuntu"
    private_key = file("id_rsa")
  }

  provisioner "file" {
    source = each.value.provisioner_file_source
    destination = each.value.provisioner_file_destination
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/${each.value.provisioner_inline}", 
        "sudo /tmp/${each.value.provisioner_inline}"
     ]
  }
}
