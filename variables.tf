variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}