variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "instance_type" {
  type  = string
}

variable "common_tags" {
  type = map(string)
}

variable "key_name" {
  type = string
}

variable "ami_name" {
  type = string
}

variable "ec2_name" {
  type = string
}