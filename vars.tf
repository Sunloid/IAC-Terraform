variable "region" {
  default = "ap-south-1"
}

variable "Instance" {
  default = {
    Jenkins = {
      Name = "JenkinsInstance"
      ami = "ami-0dee22c13ea7a9a67"
      instance_type = "t2.micro"
      availability_zone = "ap-south-1a"
      vpc_security_group_ids = "sg-0e021e9d85bb8b30c"
      provisioner_file_source = "Jenkins_Setup.sh"
      provisioner_file_destination = "/tmp/Jenkins_Setup.sh"
      provisioner_inline = "Jenkins_Setup.sh"
    },
    SonarQube = {
      Name = "SonarQubeInstance"
      ami = "ami-0dee22c13ea7a9a67"
      instance_type = "t2.medium"
      availability_zone = "ap-south-1a"
      vpc_security_group_ids = "sg-0e021e9d85bb8b30c"
      provisioner_file_source = "SonarQube_Setup.sh"
      provisioner_file_destination = "/tmp/SonarQube_Setup.sh"
      provisioner_inline = "SonarQube_Setup.sh"
    },
    Nexus = {
      Name = "NexusInstance"
      ami = "ami-0dee22c13ea7a9a67"
      instance_type = "t2.medium"
      availability_zone = "ap-south-1a"
      vpc_security_group_ids = "sg-0e021e9d85bb8b30c"
      provisioner_file_source = "Nexus_Setup.sh"
      provisioner_file_destination = "/tmp/Nexus_Setup.sh"
      provisioner_inline = "Nexus_Setup.sh"
    }
  }
}

