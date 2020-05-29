resource "aws_db_subnet_group" "mysql-subnet" {
    name = "mysql-subnet"
    subnet_ids =["${aws_subnet.main-private-3.id}","${aws_subnet.main-private-4.id}"]
}

resource "aws_db_instance" "mysql" {
    allocated_storage = 10
    storage_type = "gp2"
    engine ="mysql"
    engine_version ="5.7"
    instance_class ="db.t2.micro"
    name="mydb"
    username = "root"
    password ="${var.PASSWORD}"
    multi_az =false
    vpc_security_group_ids = ["${aws_security_group.allow-mysql.id}"]
    db_subnet_group_name ="${aws_db_subnet_group.mysql-subnet.name}"
    availability_zone = "${aws_subnet.main-private-3.availability_zone}"
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
            "mysql -u root -h ${aws_db_instance.mysql.address} -p${var.PASSWORD} mydb < /tmp/data.sql",
            "exit"
      ]
    }
}