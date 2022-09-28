provider "aws" {
  region = var.region
}
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags={Name:"${var.env_prefix}-vpc"}
}
resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {Name: "${var.env_prefix}-subnet"}
}
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {Name: "${var.env_prefix}-igw"}
}
resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  } 
  tags = {Name:"${var.env_prefix}-main-rtb"}
}
resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.my_vpc.id
  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh connection port setting"
    from_port = 22
    protocol = "tcp"
    to_port = 22
  } 
  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    description = "connection for apps"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }
  egress{
    cidr_blocks = ["0.0.0.0/0"]
    description = "outgoing requests"
    from_port = 0
    to_port = 0
    protocol = "-1"
    prefix_list_ids = []
  }
  tags = {Name:{"${var.env_prefix}-default_sg"}
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = "amazon"
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}
resource "aws_instance" "my_app_server" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.my_subnet.id
    vpc_security_group_ids =[aws_default_security_group.default_sg.id]
    availability_zone = var.avail_zone
    associate_public_ip_address = true
    key_name = "jenkins-server"
    user_data = file("entry-script.sh")
    tags = {Name:{"${var.env_prefix}-app-server"}}
  
}
output "app-server-ip" {
  value= aws_instance.my_app_server.public_ip
}