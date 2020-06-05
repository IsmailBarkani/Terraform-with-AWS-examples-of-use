resource "aws_db_subnet_group" "mysql-subnet" {
  name       = "mysql-subnet"
  subnet_ids = ["${aws_subnet.main-private-3.id}", "${aws_subnet.main-private-4.id}"]
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  port                   = "3306" #
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = "${var.DB_USER}"
  password               = "${var.DB_PASSWORD}"
  multi_az               = false
  publicly_accessible    = true
  final_snapshot_identifier =false
  vpc_security_group_ids = ["${aws_security_group.allow-mysql.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.mysql-subnet.name}"
  availability_zone      = "${aws_subnet.main-private-3.availability_zone}"
  provisioner "file" {
    #nested connection
    connection {
      type        = "ssh"
     host        =  "${aws_instance.server.public_ip}"
      user        = "${var.AWS_INSTANCE_USERNAME}"
      private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }
    source      = "script.sql"
    destination = "/tmp/script.sql"
  }

  # remote-exec provesioner
  provisioner "remote-exec" {
    #nested connection
    connection {
      type        = "ssh"
      host        = "${aws_instance.server.public_ip}"
      user        = "${var.AWS_INSTANCE_USERNAME}"
      private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }
    inline = [
      "sudo apt update",
      "echo Y | sudo apt-get install mysql-client",
      "mysql -u root -h ${aws_db_instance.mysql.address} -p${var.DB_PASSWORD} mydb < /tmp/script.sql",
      "exit",
      "exit"
    ]
  }
}