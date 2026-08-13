variable "vpc_id" {
  type        = string
  description = "VPC ID where resources are deployed"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance size"
}