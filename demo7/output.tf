output "elb" {
  value = "${aws_elb.myaap_elb.dns_name}"
}