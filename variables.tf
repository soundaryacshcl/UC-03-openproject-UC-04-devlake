variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "public_subnet_cidrs" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
}
variable "public_subnet_azs" {
  description = "The availability zones for the public subnets"
  type        = list(string)
}
variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
}
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string # Amazon Linux 2 AMI
  
}
variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
  
}
