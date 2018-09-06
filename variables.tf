variable "name" {
  default = "sakuten"
}
variable "domain" {
  default = "api.sakuten.jp"
}
variable "regions" {
  default = {
    tokyo = "ap-northeast-1"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "db_username" {}
variable "db_password" {}
variable "ssh_public_key" {}

variable "admin_cidr_ingress" {
  default = "0.0.0.0/0"
}

variable "elb_health_check_endpoint" {
  default = "/index.html"
}

variable "ec2_ami" {
  default = "ami-0567c164"
}

variable "ec2_instance_type" {
  default = "m4.medium"
}

variable "ec2_gp2_size" {
  default = "30"
}
