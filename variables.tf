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

variable "db_username" {}
variable "db_password" {}

variable "admin_cidr_ingress" {
  default = "0.0.0.0/0"
}
