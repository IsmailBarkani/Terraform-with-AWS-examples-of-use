resource "aws_key_pair" "ssh_keypair" {
  key_name   = "mypairkey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "server" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.ssh_keypair.key_name}"
  #file provisioner
  provisioner "file" {
    #nested connection
    connection {
      type        = "ssh"
      host        = "${aws_instance.server.public_ip}"
      user        = "${var.AWS_INSTANCE_USERNAME}"
      private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }
    source      = "runMe.sh"
    destination = "/tmp/runMe.sh"
  }

}