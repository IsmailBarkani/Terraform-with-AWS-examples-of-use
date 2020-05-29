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
    password ="rootroot"
    multi_az =false
    vpc_security_group_ids = ["${aws_security_group.allow-mysql.id}"]
    db_subnet_group_name ="${aws_db_subnet_group.mysql-subnet.name}"
    availability_zone = "${aws_subnet.main-private-3.availability_zone}"
}