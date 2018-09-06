resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.regions["tokyo"]}a"
  tags {
      Name = "sakuten-private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.regions["tokyo"]}c"
  tags {
      Name = "sakuten-private2"
  }
}

resource "aws_subnet" "public3" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.regions["tokyo"]}a"
  tags {
      Name = "sakuten-public3"
  }
}

resource "aws_subnet" "public4" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.regions["tokyo"]}c"
  tags {
      Name = "sakuten-public4"
  }
}
