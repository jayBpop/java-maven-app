variable "vpc_cidr_block" {
  default= "10.0.0.0/16"
}
variable "subnet_cidr_block" {
  default="10.0.10.0/24"
}
variable "avail_zone" {
  default="ap-south-1a"
}
variable "env_prefix" {
  default="dev"
}
variable "my_ip" {
  
}
variable "jenkins_ip" {
  
}
variable "instance_type" {
  default="t2.micro"
}
variable "region" {
  default="ap-south-1"
}