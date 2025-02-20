

variable "key_name" {
  description = "Tên SSH key để kết nối vào EC2"
  type        = string
}

variable "instance_type" {
  description = "Loại instance EC2"
  type        = string
}


variable "private_subnet" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default = null
}

variable "subnet_id" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}
variable "local_ip" {
  description = "ADD YOUR LOCAL IP ADDRESS"
  type        = string
}
variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

 variable "app" {
   description = "The application to install (Jenkins, Docker, Sonarqube)"
   type = string
 }
 variable "region" {
  type = string
   default = "default"
 }