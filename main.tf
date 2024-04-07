################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = true

  cluster_addons = {
    kube-proxy = {}
    vpc-cni    = {}
    coredns = {
      configuration_values = jsonencode({
        computeType = "fargate"
      })
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # Fargate profiles use the cluster primary security group so these are not utilized
  create_cluster_security_group = false
  create_node_security_group    = false

  fargate_profile_defaults = {
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
  }

  fargate_profiles = {
    example = {
      name = "example"
      selectors = [
        {
          namespace = "backend"
          labels = {
            Application = "backend"
          }
        },
        {
          namespace = "app-*"
          labels = {
            Application = "app-wildcard"
          }
        }
      ]

      # Using specific subnets instead of the subnets supplied for the cluster itself
      subnet_ids = [module.vpc.private_subnets[1]]

      tags = {
        Owner = "secondary"
      }
    }
    kube-system = {
      selectors = [
        { namespace = "kube-system" }
      ]
    }
  }

  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = var.k8s_admin_role_arn

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  tags = local.tags
}

################################################################################
# Sub-Module Usage on Existing/Separate Cluster
################################################################################

module "fargate_profile" {
  source  = "terraform-aws-modules/eks/aws//modules/fargate-profile"
  version = "20.8.4"

  name         = "${local.name}-fp"
  cluster_name = module.eks.cluster_name

  subnet_ids = module.vpc.private_subnets
  selectors = [{
    namespace = "kube-system"
  }]

  tags = merge(local.tags, { Separate = "fargate-profile" })
}


################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

resource "aws_iam_policy" "additional" {
  name = "${local.name}-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


# Adding NewRelic addon from the marketplace

resource "aws_eks_addon" "newrelic_addon" {
  depends_on    = [module.eks]
  addon_name    = "new-relic_kubernetes-operator"
  cluster_name  = module.eks.cluster_name
  addon_version = "v0.1.9-eksbuild.1"
}

resource "kubernetes_manifest" "nribundle_nribundle_sample" {
  depends_on = [ aws_eks_addon.newrelic_addon]
  manifest = {
    "apiVersion" = "newrelic.com/v1alpha1"
    "kind" = "NRIBundle"
    "metadata" = {
      "name" = "nribundle-sample"
    }
    "spec" = {
      "global" = {
        "cluster" = module.eks.cluster_name
        "licenseKey" = var.nr_license_key
        "lowDataMode" = true
      }
      "kube-state-metrics" = {
        "enabled" = true
        "image" = {
          "tag" = "v2.10.0"
        }
      }
      "kubeEvents" = {
        "enabled" = true
      }
      "newrelic-infrastructure" = {
        "enabled" = true
        "privileged" = true
      }
      "newrelic-prometheus-agent" = {
        "config" = {
          "kubernetes" = {
            "integrations_filter" = {
              "enabled" = false
            }
          }
        }
        "enabled" = true
        "lowDataMode" = true
      }
    }
  }
}

