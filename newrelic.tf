resource "kubernetes_manifest" "deployment_inflate" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "inflate"
    }
    "spec" = {
      "replicas" = 0
      "selector" = {
        "matchLabels" = {
          "app" = "inflate"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "inflate"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "public.ecr.aws/eks-distro/kubernetes/pause:3.7"
              "name" = "inflate"
              "resources" = {
                "requests" = {
                  "cpu" = 1
                }
              }
            },
          ]
          "terminationGracePeriodSeconds" = 0
        }
      }
    }
  }
}
