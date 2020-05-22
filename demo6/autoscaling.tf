resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example_launchconfig"
  image_id        = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.mykey.key_name}"
  security_groups = ["${aws_security_group.groupe.id}"]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
}
resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"] #for the high availibility
  launch_configuration      = "${aws_launch_configuration.example-launchconfig.name}"
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 300 #in seconds
  health_check_type         = "ELB"
  load_balancers            = ["${aws_elb.my-elb.name}"]
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}