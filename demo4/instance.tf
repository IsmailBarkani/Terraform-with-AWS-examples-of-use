resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "server" {
  ami                    = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.main-public-1.id}"
  vpc_security_group_ids = ["${aws_security_group.groupe.id}"]
  key_name               = "${aws_key_pair.mykey.key_name}"
}