
# CIDR block for the VPC
vpc_cidr_block = "10.0.0.0/16"  # Replace with your desired CIDR block, e.g., "192.168.0.0/16"

# List of private subnet CIDR blocks


# List of public subnet CIDR blocks
subnet_id = [
  "10.0.3.0/24" # Replace with your public subnet CIDR, e.g., "192.168.3.0/24"  # Add additional public subnets as needed
]

# List of availability zones for the subnets
availability_zones = [
  "ap-southeast-1a"  # Replace with your desired availability zones, e.g., "us-east-1a"  # Add additional availability zones as needed
]



# AMI ID for private instances


# Type of EC2 instance
instance_type = "t3.medium"  # Change to your preferred instance type, e.g., "t2.medium"

# Key pair name for SSH access to instances
key_name = "aws-test"  # Replace with the name of your SSH key pair

# ADD YOUR LOCAL IP ADDRESS
local_ip = "27.78.217.145"  # Change to your actual local IP address, e.g., "192.168.1.100"

app = "sonarqube"

region = "ap-southeast-1"
