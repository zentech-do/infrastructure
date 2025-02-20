

variable "key_name" {
  description = "Tên SSH key để kết nối vào EC2"
  type        = string
}

variable "instance_type" {
  description = "Loại instance EC2"
  type        = string
}

variable "security_group_ids" {
  description = "ID của Security Group cho public instance"
  type        = string
}

variable "subnet_id" {
  description = "ID của public subnet"
  type        = list(string)
}

variable "public_ami_id" {
  description = "ID của AMI sử dụng cho public instance"
  type        = string
}
 variable "app" {
   description = "The application to install (Jenkins, Docker, Sonarqube)"
   type = string
 }

 variable "profile" {
  type    = string
  default = "default"
}
variable "region" {
  type = string
   default = "default"
 }
