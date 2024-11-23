variable "ami" {
  default = "ami-0dee22c13ea7a9a67"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "vpc_security_group_ids" {
  // Allows all traffic 
  default = "sg-0e021e9d85bb8b30c"
}

variable "instance_type" {
  default = "t2.micro"
}