#Create Aws public instances in public subnets
resource "aws_instance" "public_instance" {
  count = length(var.subnet_id)
  ami               = var.public_ami_id 
  instance_type     = var.instance_type  
  key_name          = var.key_name  
  subnet_id         = var.subnet_id[count.index]
  vpc_security_group_ids = [var.security_group_ids]  
  associate_public_ip_address = true  

  tags = {
    Name = "${var.app}-Server" 
  }
  provisioner "local-exec" {
    command = "aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region} --instance-ids ${self.id} &&  ansible-playbook -i ../../ansible/inventory/aws_ec2.yaml ../../ansible/site.yml "
  }
}

