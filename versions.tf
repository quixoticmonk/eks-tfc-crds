terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"
    }
    # kubernetes = {
    #   source = "hashicorp/kubernetes"
    #   version = "2.27.0"
    # }
  }
}

provider "aws" {
  region = local.region
}


# provider "kubernetes" {
#   host = module.eks.cluster_endpoint

#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
# }