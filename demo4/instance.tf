resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

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
  user_data = "${data.template_cloudinit_config.cloudinit_example.rendered}"
}

#add an extra EBS(elastic block sotrage) to the instance
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-west-3a"
  size              = "2"
  type              = "gp2" #SSD
  tags = {
    name = "Extra volume data"
  }
}

#attache the volume block in our instance
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = "${aws_ebs_volume.ebs-volume-1.id}"
  instance_id = "${aws_instance.server.id}"
}