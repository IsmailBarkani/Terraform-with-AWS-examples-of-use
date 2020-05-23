resource "aws_security_group" "ecs-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "ecs"
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port         = "3000"
    from_port       = "3000"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.myapp-elb-securitygroup.id}"]
  }
  ingress {
    to_port     = "22"
    from_port   = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "ecs"
  }
}

resource "aws_security_group" "myapp-elb-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "myapp-elb"
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = "80"
    from_port   = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "myapp-elb"
  }
}