variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = " "
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = " "
}
variable "public_subnet_cidrs" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
  default     = [" "]
}
variable "public_subnet_azs" {
  description = "The availability zones for the public subnets"
  type        = list(string)
  default     = [" "]
}
variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = " "
}
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
  default     = " " # Amazon Linux 2 AMI
  
}
variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
  default     = " "
  
}
