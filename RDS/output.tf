output "instance" {
    value ="${aws_instance.server.public_ip}"
}
output "endpoint" {
    value ="${aws_db_instance.mysql.endpoint}"
}
output "address" {
    value ="${aws_db_instance.mysql.address}"
}