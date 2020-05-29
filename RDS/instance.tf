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
  #user_data = "${data.template_cloudinit_config.cloudinit_example.rendered}"
  provisioner "file" {
    #nested connection
    connection {
      type        = "ssh"
      host        = "${aws_instance.server.public_ip}"
      user        = "${var.AWS_INSTANCE_USERNAME}"
      private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }
    source      = "data.sql"
    destination = "/tmp/data.sql"
  }

  # remote-exec provesioner
    provisioner "remote-exec"{
        #nested connection
        connection{
            type="ssh"
            host="${aws_instance.server.public_ip}"
            user = "${var.AWS_INSTANCE_USERNAME}"
            private_key= "${file("${var.PATH_TO_PRIVATE_KEY}")}"
        }
        inline=[
            "sudo apt update",
            "echo Y | sudo apt-get install mysql-client",
            "sudo -s",
            "mysql -u root -h ${aws_db_instance.mysql.address} -p'rootroot' < /tmp/data.sql"
      ]
    }
}