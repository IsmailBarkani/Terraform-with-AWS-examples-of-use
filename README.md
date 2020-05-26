# Terraform with AWS
[![Terraform](https://img.shields.io/static/v1?label=Terraform&message=v0.12.25&color=blueviolet&logo=Terraform)](https://www.terraform.io/downloads.html)
[![AWS](https://img.shields.io/static/v1?label=AWS-CLI&message=v1.18.60&color=orange&logo=amazon)](https://aws.amazon.com/fr/cli/)

 - **Save your AWS access key in a .tfvars file (never share a .tfvars file)**

```
AWS_ACCESS_KEY="XXXXXYY"
AWS_SECRET_KEY="YYYYXXXXXXXX"
```

- **Initialize your working directory**

```
$ terraform init
```

- **Apply**

```
$ terraform apply
```

- **Authenticating Amazon ECR Repositories for Docker CLI** 

Use the commande above to retrieves the token
```
$ aws ecr get-login-password
```
copy the token, in run the following commande

```bash
$ docker login  –p token –e none https://aws_account_id.dkr.ecr.your_region.amazonaws.com
```
