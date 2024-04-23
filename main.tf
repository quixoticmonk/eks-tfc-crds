
resource "kubernetes_manifest" "nribundle_nribundle_sample" {
  depends_on = [ data.aws_eks_cluster.this]
  manifest = {
    "apiVersion" = "newrelic.com/v1alpha1"
    "kind" = "NRIBundle"
    "metadata" = {
      "name" = "nribundle-sample"
      "namespace" = "newrelic"
    }
    "spec" = {
      "global" = {
        "cluster" = local.name
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
              "enabled" = true
            }
          }
        }
        "enabled" = true
        "lowDataMode" = true
      }
    }
  }
}

