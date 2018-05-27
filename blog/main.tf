provider "aws" {
    region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "terraform-gneto"
    key    = "terraform-blog/production/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
# shared_credentials_file = "/home/germano.neto/.aws/credentials"
  }
}

module "blog" {
  source = "../modules/"
  region = "${var.region}"
  account_id = "${var.account_id}"
  vpc_id = "${var.vpc_id}"
  app_subnet_private = "${var.app_subnet_private}"
  app_subnet_public = "${var.app_subnet_public}"
  instance_type = "${var.instance_type}"
  ami_id = "${var.ami_id}"
  key_name = "${var.key_name}"
  tags = "${var.tags}"
}
