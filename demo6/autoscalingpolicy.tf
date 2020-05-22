#scaling up 
resource "aws_autoscaling_policy" "example-cpu-policy" {
  name                   = "example-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.example-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"   # up 1 
  cooldown               = "300" #seconds
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name          = "example-cpu-alarm"
  alarm_description   = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30" #%

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.example-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.example-cpu-policy.arn}"]
}

#scaling down
#scaling up 
resource "aws_autoscaling_policy" "example-cpu-policy-scaling-down" {
  name                   = "example-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.example-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"  # down 1 
  cooldown               = "300" #seconds
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaling-down" {
  alarm_name          = "example-cpu-alarm-scaling-down"
  alarm_description   = "example-cpu-alarm-scaling-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5" #%

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.example-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.example-cpu-policy-scaling-down.arn}"]
}