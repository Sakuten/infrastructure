provider "aws" {
  region = "${var.regions["tokyo"]}"
  alias  = "tokyo"
}
