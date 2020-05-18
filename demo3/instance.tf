data "aws_ip_ranges" "ip_range" {
  regions  = ["eu-south-1", "eu-west-3"]
  services = ["ec2"]
}

resource "aws_security_group" "groupe_ip" {
  name = "groupe_ip"
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = "${data.aws_ip_ranges.ip_range.cidr_blocks}"
  }
}