provider "aws" {
  region = "us-east-1"
}

mock_provider "aws" {
  alias = "mock_aws"
}

variables {
  k8s_admin_role_arn = "arn:aws:iam::123456789012:role/something"
  cluster_version    = "1.29"
}

run "variabe_validations" {
  command = plan

  providers = {
    aws = aws.mock_aws
  }

  variables {
    k8s_admin_role_arn = "arn:aws:iam::123456789012:role/something"
    cluster_version    = "1.9"
  }

  expect_failures = [var.cluster_version]
}