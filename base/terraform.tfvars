app = "airflow"

environment = "dev"

region = "us-east-1"

aws_profile = "aws-cloudarch-sandbox:aws-cloudarch-sandbox-admin"

saml_role = "aws-cloudarch-sandbox-admin"

secrets_saml_users = []

vpc = "vpc-8334f9f9"

private_subnets = "subnet-e34f0da9,subnet-dab60ff4"

public_subnets = "subnet-6c4d0f26,subnet-f9a71ed7"

tags = {
  application   = "airflow"
  environment   = "dev"
  team          = "cloudarch"
  customer      = "cloudarch"
  contact-email = "john.ritsema@turner.com"
}

schedule_expression = "rate(60 minutes)"
