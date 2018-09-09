variable "base_name" {
  default = "sakuten"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "secret_key" {}
variable "recaptcha_secret_key" {}
variable "db_username" {}
variable "db_password" {}
variable "dbgen_schedule" {}

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

variable "container_port" {
  default     = "80"
}

variable "alb_container_port" {
  default     = "8080"
}

variable "domain" {
  default = "sakuten.jp"
}

variable "netlify_domain" {
  default = "sakuten-deployment.netlify.com"
}
