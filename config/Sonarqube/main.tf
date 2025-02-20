
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
  source = "../../modules/vpc"  # Đảm bảo đường dẫn đến module là chính xác

  vpc_cidr_block = "10.0.0.0/16"
  vpc_name       = "MyVPC"  # Thêm tên cho VPC nếu cần
}

# Module Subnets
module "subnets" {
  source = "../../modules/subnets"

  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = var.subnet_id
  private_subnet_cidrs = var.private_subnet
  availability_zones   = var.availability_zones
}

# Module Security Groups
module "security_groups" {
  source = "../../modules/security-groups"
  vpc_id = module.vpc.vpc_id
  local_ip = var.local_ip
  sg_name = "sonarqube-sg"
  
  ingress_rules = [
    { f_port = 22, t_port = 22, protocol = "tcp", cidr_blocks = ["${var.local_ip}/32"] },  # SSH (chỉ từ IP của bạn)
    { f_port = 9000, t_port = 9000, protocol = "tcp", cidr_blocks = ["${var.local_ip}/32"] },      # Port 9000 (SonarQube Web UI, mở cho tất cả)
    { f_port = 5432, t_port = 5432, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },      # Port 5432 (PostgreSQL nếu sử dụng DB ngoài SonarQube, mở cho tất cả)
    { f_port = 8082, t_port = 8082, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }       # Port 8082 (SonarQube API, mở cho tất cả)
  ]

  egress_rules = [
    { f_port = 0, t_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }  # Cho phép tất cả outbound traffic
  ]
}

# Module Routables
module "routables" {
  source = "../../modules/routables"
  vpc_id          = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
}
module "SonarQube-server" {
  source = "../../modules/ec2"
  public_ami_id      = data.aws_ami.ubuntu.id
  app                = var.app
  instance_type      = var.instance_type
  subnet_id          = module.subnets.public_subnet_ids
  security_group_ids = module.security_groups.aws_dynamic_sg
  key_name           = var.key_name 
  region             = var.region
}
