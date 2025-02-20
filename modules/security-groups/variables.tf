variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "local_ip" {
  description = "YOUR LOCAL IP ADRESS  171.252.155.195"
  type        = string          
} 

variable "sg_name" {
  description = "Tên security Group"
  type        = string
}

variable "ingress_rules" {
  description = "Danh sách ingress rules"
  type = list(object({
    f_port = number
    t_port = number
    protocol = string
    cidr_blocks = list(string) 
  }))
}

variable "egress_rules" {
  description = "Danh sách egress rules"
  type = list(object({
    f_port = number
    t_port = number
    protocol = string
    cidr_blocks = list(string) 
  }))
}