variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-west-3"
}
variable "AMIS" {
  type = "map"
  default = {
    eu-west-3  = "ami-0081c55264b4f42a1"
    eu-south-1 = "ami-0ae82b98c54a93226"
  }
}

variable "ECS_AMIS" {
  type = "map"
  default = {
    eu-west-3 = "ami-032a9f3e531acca53"
  }
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "AWS_INSTANCE_USERNAME" {
  default = "ubuntu"
}