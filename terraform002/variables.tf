variable "region" {
    description = "The region to use"
    type = string
    default = "ap-south-1"

}
variable "az" {
    description = "private network and availability zone"
    type = string
    default = "af-south-1a"
  
}
variable "vpc_cidr_block" {
    description = "The VPC addresses range"
    type = string
    default = "10.10.0.0/16"

}
variable "subnet_cidr_block" {
    description = "The private subnet addresses range"
    type = string
    default = "10.10.0.0/24"

}
variable "instance_type" {
    description = "Instance type"
    type = string
    default = "t2.micro"
  
}
