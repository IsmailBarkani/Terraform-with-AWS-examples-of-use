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
    to_port         = 8080#
    from_port       = 8080#
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
    to_port     = 8080
    from_port   = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "myapp-elb"
  }
}


resource "aws_security_group" "groupe" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "allow_ssh"
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = "0"
    from_port   = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "allow-ssh"
  }
}

resource "aws_security_group" "allow-mysql" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "allow-mysql"
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port         = "3306"
    from_port       = "3306"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.groupe.id}"]
  }
  tags = {
    name = "allow-mysql"
  }
}