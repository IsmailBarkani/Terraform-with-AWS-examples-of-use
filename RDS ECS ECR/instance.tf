

resource "aws_instance" "server" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  #subnet id wich where we gonna put the instance
  subnet_id = "${aws_subnet.main-public-1.id}"
  #the security groupe for our instance
  vpc_security_group_ids = ["${aws_security_group.groupe.id}"]
  #key pair name
  key_name = "${aws_key_pair.mykey.key_name}"
  #user data
  #user_data = "${data.template_cloudinit_config.cloudinit_example.rendered}"
}