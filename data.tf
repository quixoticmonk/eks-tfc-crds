
locals {
  name            = "marketplace-webinar-demo"
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