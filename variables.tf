variable "vpc_name" {
  description = "Name of the VPC"
}

variable "aws_region" {
  description = "Region for the VPC"
}

variable "aws_zone_1a" {
  description = "AZ for the VPC"
}

variable "aws_zone_1b" {
  description = "AZ for the VPC"
}

variable "aws_zone_1c" {
  description = "AZ for the VPC"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_1" {
  description = "CIDR for the public subnet in zone a"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR for the public subnet in zone b"
  default     = "10.0.2.0/24"
}

variable "public_subnet_cidr_3" {
  description = "CIDR for the public subnet in zone c"
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_1" {
  description = "CIDR for the private subnet in zone a"
  default     = "10.0.4.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR for the private subnet in zone b"
  default     = "10.0.5.0/24"
}

variable "private_subnet_cidr_3" {
  description = "CIDR for the private subnet in zone c"
  default     = "10.0.6.0/24"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = "~/.ssh/id_rsa.pub"
}
