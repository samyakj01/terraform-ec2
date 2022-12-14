#provider variables
aws_access_key = "my-access-key"
aws_secret_key = "my-secret-key"
aws_region     = "us-east-1"
#Subnet variables
public-ip         = true
availability_zone = "us-east-1a"
#Instance variable
instance-ami       = "my-ami"
instance_type      = "t2.micro"
key_name           = "MyKey"
cpu_core_count     = 2
ipv6_address_count = 0    #count of ipv6 address
ipv6_addresses     = [""] #list of ipv6 address
#Map of Tags
tags = {
  VpcName = "custom"
  SubName = "Public Subnet"
  IGName  = "IG-Public-VPC"
  RTName  = "Route Table for Internet Gateway"
  SGName  = "allow-ssh"
  EC2Name = "MyEc2 instance"
}