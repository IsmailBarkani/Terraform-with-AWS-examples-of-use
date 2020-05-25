resource "aws_security_group" "groupe" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "allow_ssh"
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = "0"
    from_port   = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "allow-ssh"
  }
}