variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "Availability zones for the public subnets"
  type        = list(string)
}