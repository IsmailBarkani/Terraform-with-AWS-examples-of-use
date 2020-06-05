output "elb" {
  value = "${aws_elb.myaap_elb.dns_name}"
}

output "endpoint" {
  value = "${aws_db_instance.mysql.endpoint}"
}
output "address" {
  value = "${aws_db_instance.mysql.address}"
}