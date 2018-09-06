resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "public"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.public3.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "d" {
  subnet_id      = "${aws_subnet.public4.id}"
  route_table_id = "${aws_route_table.public.id}"
}
