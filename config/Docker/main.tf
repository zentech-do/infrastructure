
provider "aws" {
  region = "ap-southeast-1"
  
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}



# Module VPC
module "vpc" {
  source         = "../../modules/vpc"  # Đảm bảo đường dẫn đến module là chính xác

  vpc_cidr_block = "10.0.0.0/16"
  vpc_name       = "MyVPC"  # Thêm tên cho VPC nếu cần
}

# Module Subnets
module "subnets" {
  source = "../../modules/subnets"

  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = var.subnet_id
  private_subnet_cidrs = var.private_subnet
  availability_zones   = var.availability_zones
}

# Module Security Groups
module "security_groups" {
  source         = "../../modules/security-groups"
  vpc_id         = module.vpc.vpc_id
  local_ip       = var.local_ip
  sg_name        = "docker-sg"
   ingress_rules = [
    { f_port = 22, t_port = 22, protocol = "tcp", cidr_blocks = ["${var.local_ip}/32"] },       # SSH (chỉ từ IP của bạn)
    { f_port = 2375, t_port = 2375, protocol = "tcp", cidr_blocks = ["10.0.1.0/24"] },            # Docker Remote API (mở cho tất cả, nhưng nên hạn chế nếu không cần thiết)
    { f_port = 80, t_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },                # HTTP (mở cho tất cả)
    { f_port = 443, t_port = 443, protocol = "tcp", cidr_blocks = ["10.0.1.0/24"] }               # HTTPS (mở cho tất cả)
]

egress_rules     = [
    { f_port = 0, t_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }  # Cho phép tất cả outbound traffic
]
}
# Module Routables
module "routables" {
  source            = "../../modules/routables"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
}
module "Docker-server" {
  source = "../../modules/ec2"
  public_ami_id      = data.aws_ami.ubuntu.id
  app                = var.app
  instance_type      = var.instance_type
  subnet_id          = module.subnets.public_subnet_ids
  security_group_ids = module.security_groups.aws_dynamic_sg
  key_name           = var.key_name 
  region             = var.region
}
