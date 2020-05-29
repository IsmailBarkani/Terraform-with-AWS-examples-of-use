resource "aws_key_pair" "ssh_keypair" {
  key_name   = "mypairkey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "server" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.ssh_keypair.key_name}"
  
}