terraform {
  required_version = ">=1.7.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  backend "s3" {
    region  = "ap-southeast-1"
    profile = "default"
    key     = "Jenkins/terraform.tfstate"
    bucket  = "jenkins-state-cloud"
  }
}