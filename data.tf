
locals {
  name            ="marketplace-webinar"
  region          = "us-east-1"

  tags = {
    create_by = "manuchn"
    product  = "webinar-example"
  }
}


data "aws_eks_cluster" "this" {
  name = local.name
}
data "aws_eks_cluster_auth" "this" {
  name = local.name
}

data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.virginia
}



data "aws_iam_openid_connect_provider" "this" {
  url = data.aws_eks_cluster.this.identity.oidc.issuer
}