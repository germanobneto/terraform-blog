variable "region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "blog"
}

variable "account_id" {
  default = "133840611900"
}

variable "vpc_id" {
  default = "vpc-e82c1093"
}

variable "app_subnet_private" {
  default = "subnet-66f53348"
}

variable "app_subnet_public" {
  default = "subnet-3dff3913"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-5c66ea23"
}

variable "key_name" {
  default = "gneto"
}

variable "tags" {
  type = "map"

  default = {
    "Name"    = "blog"
    "Env"     = "prod"
    "Team"    = "blog"
    "Area"    = "marketing"
    "Project" = "blog"
  }
}
