resource "aws_security_group" "groupe_ip" {
  name = "groupe_ip"
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "tcp"
    cidr_blocks = ["41.143.139.78/32"]
  }
}