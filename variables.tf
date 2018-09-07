variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "secret_key" {}
variable "recaptcha_secret_key" {}
variable "db_username" {}
variable "db_password" {}

variable "ssh_public_key" {}

variable "db_instance_type" {
  default = "db.t2.small"
}
variable "instance_type" {
  default     = "t2.small"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}

variable "admin_cidr_ingress" {
  description = "CIDR to allow tcp/22 ingress to EC2 instance"
}
