#create a aws registry (ecr=ec2 registry)
resource "aws_ecr_repository" "myapp" {
  name = "myapp"
}