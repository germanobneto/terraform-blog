variable "region" {
  default = "string"
}

variable "app_name" {
  default = "string"
}

variable "account_id" {
  default = "string"
}

variable "vpc_id" {
  default = "string"
}

variable "app_subnet_private" {
  default = "string"
}

variable "app_subnet_public" {
  default = "string"
}

variable "instance_type" {
  default = "string"
}

variable "ami_id" {
  default = "string"
}

variable "key_name" {
  default = "string"
}

variable "tags" {
  type = "map"
}
