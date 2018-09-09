variable "base_name" {
  default = "sakuten"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-northeast-1"
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
variable "acme_email" {}
variable "admin_secret_id" {}

variable "ssh_public_key" {}

variable "ecs_image_url" {
  default = "sakuten/backend:latest"
}

variable "acme_server_url" {
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "db_instance_type" {
  default = "db.t2.2xlarge"
}

variable "instance_type" {
  default     = "t3.large"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "2"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "5"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "2"
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
  default = "sakuten.netlify.com"
}

variable "health_check_path" {
  default = "/lotteries"
}

variable "dbgen_archive_path" {
  default = "dbgen_function.zip"
}

variable "drawer_archive_path" {
  default = "drawer_function.zip"
}

variable "drawer_source_path" {
  default = "drawer/"
}

variable "tps" {
  default = [
    "cron(23 0 16,17 9 ? 2018)",
    "cron(48 1 16,17 9 ? 2018)",
    "cron(58 3 16,17 9 ? 2018)",
    "cron(23 5 16,17 9 ? 2018)",
  ]
}
