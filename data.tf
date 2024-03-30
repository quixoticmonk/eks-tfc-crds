data "aws_availability_zones" "available" {}

locals {
  name            = "marketplace-webinar-demo"
  cluster_version = var.cluster_version
  region          = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    create_by = "manuchn"
    product  = "webinar-example"
  }
}

data "http" "terraform_io" {
  url = "https://www.terraform.io"

  lifecycle {
    postcondition {
        condition = self.status_code == 200
        error_message = "${self.url} returned an unhealthy status code"
    }
  }
}
