resource "kubernetes_manifest" "clusterrolebinding_nri_bundle_kube_state_metrics" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "metrics"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "kube-state-metrics"
        "app.kubernetes.io/part-of" = "kube-state-metrics"
        "app.kubernetes.io/version" = "2.10.0"
        "helm.sh/chart" = "kube-state-metrics-5.12.1"
      }
      "name" = "nri-bundle-kube-state-metrics"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "nri-bundle-kube-state-metrics"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-kube-state-metrics"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "deployment_newrelic_nri_bundle_kube_state_metrics" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "metrics"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "kube-state-metrics"
        "app.kubernetes.io/part-of" = "kube-state-metrics"
        "app.kubernetes.io/version" = "2.10.0"
        "helm.sh/chart" = "kube-state-metrics-5.12.1"
      }
      "name" = "nri-bundle-kube-state-metrics"
      "namespace" = "newrelic"
    }
    "spec" = {
      "replicas" = 1
      "revisionHistoryLimit" = 10
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/instance" = "nri-bundle"
          "app.kubernetes.io/name" = "kube-state-metrics"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/component" = "metrics"
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "kube-state-metrics"
            "app.kubernetes.io/part-of" = "kube-state-metrics"
            "app.kubernetes.io/version" = "2.10.0"
            "helm.sh/chart" = "kube-state-metrics-5.12.1"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--port=8080",
                "--resources=certificatesigningrequests,configmaps,cronjobs,daemonsets,deployments,endpoints,horizontalpodautoscalers,ingresses,jobs,leases,limitranges,mutatingwebhookconfigurations,namespaces,networkpolicies,nodes,persistentvolumeclaims,persistentvolumes,poddisruptionbudgets,pods,replicasets,replicationcontrollers,resourcequotas,secrets,services,statefulsets,storageclasses,validatingwebhookconfigurations,volumeattachments",
              ]
              "image" = "registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.10.0"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 8080
                }
                "initialDelaySeconds" = 5
                "timeoutSeconds" = 5
              }
              "name" = "kube-state-metrics"
              "ports" = [
                {
                  "containerPort" = 8080
                  "name" = "http"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/"
                  "port" = 8080
                }
                "initialDelaySeconds" = 5
                "timeoutSeconds" = 5
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "capabilities" = {
                  "drop" = [
                    "ALL",
                  ]
                }
              }
            },
          ]
          "hostNetwork" = false
          "securityContext" = {
            "fsGroup" = 65534
            "runAsGroup" = 65534
            "runAsNonRoot" = true
            "runAsUser" = 65534
            "seccompProfile" = {
              "type" = "RuntimeDefault"
            }
          }
          "serviceAccountName" = "nri-bundle-kube-state-metrics"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "clusterrole_nri_bundle_kube_state_metrics" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "metrics"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "kube-state-metrics"
        "app.kubernetes.io/part-of" = "kube-state-metrics"
        "app.kubernetes.io/version" = "2.10.0"
        "helm.sh/chart" = "kube-state-metrics-5.12.1"
      }
      "name" = "nri-bundle-kube-state-metrics"
    }
    "rules" = [
      {
        "apiGroups" = [
          "certificates.k8s.io",
        ]
        "resources" = [
          "certificatesigningrequests",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "batch",
        ]
        "resources" = [
          "cronjobs",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "extensions",
          "apps",
        ]
        "resources" = [
          "daemonsets",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "extensions",
          "apps",
        ]
        "resources" = [
          "deployments",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "endpoints",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "autoscaling",
        ]
        "resources" = [
          "horizontalpodautoscalers",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "extensions",
          "networking.k8s.io",
        ]
        "resources" = [
          "ingresses",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "batch",
        ]
        "resources" = [
          "jobs",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "limitranges",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "admissionregistration.k8s.io",
        ]
        "resources" = [
          "mutatingwebhookconfigurations",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "namespaces",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "networking.k8s.io",
        ]
        "resources" = [
          "networkpolicies",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "nodes",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "persistentvolumeclaims",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "persistentvolumes",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "policy",
        ]
        "resources" = [
          "poddisruptionbudgets",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "extensions",
          "apps",
        ]
        "resources" = [
          "replicasets",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "replicationcontrollers",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "resourcequotas",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "services",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "statefulsets",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "storage.k8s.io",
        ]
        "resources" = [
          "storageclasses",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "admissionregistration.k8s.io",
        ]
        "resources" = [
          "validatingwebhookconfigurations",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "storage.k8s.io",
        ]
        "resources" = [
          "volumeattachments",
        ]
        "verbs" = [
          "list",
          "watch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "service_newrelic_nri_bundle_kube_state_metrics" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "annotations" = {
        "prometheus.io/scrape" = "true"
      }
      "labels" = {
        "app.kubernetes.io/component" = "metrics"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "kube-state-metrics"
        "app.kubernetes.io/part-of" = "kube-state-metrics"
        "app.kubernetes.io/version" = "2.10.0"
        "helm.sh/chart" = "kube-state-metrics-5.12.1"
      }
      "name" = "nri-bundle-kube-state-metrics"
      "namespace" = "newrelic"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 8080
          "protocol" = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "kube-state-metrics"
      }
      "type" = "ClusterIP"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_newrelic_nri_bundle_kube_state_metrics" {
  manifest = {
    "apiVersion" = "v1"
    "imagePullSecrets" = null
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "metrics"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "kube-state-metrics"
        "app.kubernetes.io/part-of" = "kube-state-metrics"
        "app.kubernetes.io/version" = "2.10.0"
        "helm.sh/chart" = "kube-state-metrics-5.12.1"
      }
      "name" = "nri-bundle-kube-state-metrics"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "clusterrole_nri_bundle_newrelic_infrastructure" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-newrelic-infrastructure"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "nodes/metrics",
          "nodes/stats",
          "nodes/proxy",
        ]
        "verbs" = [
          "get",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "endpoints",
          "services",
          "nodes",
          "namespaces",
          "pods",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "nonResourceURLs" = [
          "/metrics",
        ]
        "verbs" = [
          "get",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_nri_bundle_newrelic_infrastructure" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-newrelic-infrastructure"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "nri-bundle-newrelic-infrastructure"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-newrelic-infrastructure"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nrk8s_agent_controlplane" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "newrelic-infra.yml" = <<-EOT
      # This is the configuration file for the infrastructure agent. See:
      # https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/configuration/infrastructure-agent-configuration-settings/
      custom_attributes:
        clusterName: marketplace-webinar
      http_server_enabled: true
      http_server_port: 8001
      is_forward_only: true
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-agent-controlplane"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "clusterrole_nri_bundle_nrk8s_controlplane" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-controlplane"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "nodes/metrics",
          "nodes/stats",
          "nodes/proxy",
        ]
        "verbs" = [
          "get",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods",
          "nodes",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "nonResourceURLs" = [
          "/metrics",
        ]
        "verbs" = [
          "get",
          "head",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_nri_bundle_nrk8s_controlplane" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-controlplane"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "nri-bundle-nrk8s-controlplane"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-nrk8s-controlplane"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "daemonset_newrelic_nri_bundle_nrk8s_controlplane" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "DaemonSet"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
        "mode" = "privileged"
      }
      "name" = "nri-bundle-nrk8s-controlplane"
      "namespace" = "newrelic"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "controlplane"
          "app.kubernetes.io/instance" = "nri-bundle"
          "app.kubernetes.io/name" = "newrelic-infrastructure"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "checksum/agent-config" = "2318260639ed849b12bc16dd54f7971ac36c5e3ffb267b6c0843ee81f2e19db0"
            "checksum/license-secret" = "d0568251dac295b1dd7c0774b38855f7933808634d3e4dfe97e41e42bd6515d2"
            "checksum/nri-kubernetes" = "8d41845c7188a35bbce2964c03f3a5138df08aa40cec51ba9652c01ce602769d"
          }
          "labels" = {
            "app.kubernetes.io/component" = "controlplane"
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "newrelic-infrastructure"
            "mode" = "privileged"
          }
        }
        "spec" = {
          "affinity" = {
            "nodeAffinity" = {
              "requiredDuringSchedulingIgnoredDuringExecution" = {
                "nodeSelectorTerms" = [
                  {
                    "matchExpressions" = [
                      {
                        "key" = "node-role.kubernetes.io/control-plane"
                        "operator" = "Exists"
                      },
                    ]
                  },
                  {
                    "matchExpressions" = [
                      {
                        "key" = "node-role.kubernetes.io/controlplane"
                        "operator" = "Exists"
                      },
                    ]
                  },
                  {
                    "matchExpressions" = [
                      {
                        "key" = "node-role.kubernetes.io/etcd"
                        "operator" = "Exists"
                      },
                    ]
                  },
                  {
                    "matchExpressions" = [
                      {
                        "key" = "node-role.kubernetes.io/master"
                        "operator" = "Exists"
                      },
                    ]
                  },
                ]
              }
            }
          }
          "containers" = [
            {
              "env" = [
                {
                  "name" = "NRI_KUBERNETES_SINK_HTTP_PORT"
                  "value" = "8001"
                },
                {
                  "name" = "NRI_KUBERNETES_CLUSTERNAME"
                  "value" = "marketplace-webinar"
                },
                {
                  "name" = "NRI_KUBERNETES_VERBOSE"
                  "value" = "false"
                },
                {
                  "name" = "NRI_KUBERNETES_NODENAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
                {
                  "name" = "NRI_KUBERNETES_NODEIP"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "status.hostIP"
                    }
                  }
                },
              ]
              "image" = "newrelic/nri-kubernetes:3.28.2"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "controlplane"
              "resources" = {
                "limits" = {
                  "memory" = "300M"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "150M"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem" = true
                "runAsGroup" = 2000
                "runAsUser" = 1000
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/newrelic-infra/nri-kubernetes.yml"
                  "name" = "nri-kubernetes-config"
                  "subPath" = "nri-kubernetes.yml"
                },
              ]
            },
            {
              "env" = [
                {
                  "name" = "NRIA_LICENSE_KEY"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "licenseKey"
                      "name" = "nri-bundle-newrelic-infrastructure-license"
                    }
                  }
                },
                {
                  "name" = "NRIA_DNS_HOSTNAME_RESOLUTION"
                  "value" = "false"
                },
                {
                  "name" = "K8S_NODE_NAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
              ]
              "image" = "newrelic/k8s-events-forwarder:1.52.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "forwarder"
              "ports" = [
                {
                  "containerPort" = 8001
                },
              ]
              "resources" = {
                "limits" = {
                  "memory" = "300M"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "150M"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem" = true
                "runAsGroup" = 2000
                "runAsUser" = 1000
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/db/newrelic-infra/data"
                  "name" = "forwarder-tmpfs-data"
                },
                {
                  "mountPath" = "/var/db/newrelic-infra/user_data"
                  "name" = "forwarder-tmpfs-user-data"
                },
                {
                  "mountPath" = "/tmp"
                  "name" = "forwarder-tmpfs-tmp"
                },
                {
                  "mountPath" = "/etc/newrelic-infra.yml"
                  "name" = "config"
                  "subPath" = "newrelic-infra.yml"
                },
              ]
            },
          ]
          "dnsPolicy" = "ClusterFirstWithHostNet"
          "hostNetwork" = true
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "serviceAccountName" = "nri-bundle-nrk8s-controlplane"
          "tolerations" = [
            {
              "effect" = "NoSchedule"
              "operator" = "Exists"
            },
            {
              "effect" = "NoExecute"
              "operator" = "Exists"
            },
          ]
          "volumes" = [
            {
              "configMap" = {
                "items" = [
                  {
                    "key" = "nri-kubernetes.yml"
                    "path" = "nri-kubernetes.yml"
                  },
                ]
                "name" = "nri-bundle-nrk8s-controlplane"
              }
              "name" = "nri-kubernetes-config"
            },
            {
              "emptyDir" = {}
              "name" = "forwarder-tmpfs-data"
            },
            {
              "emptyDir" = {}
              "name" = "forwarder-tmpfs-user-data"
            },
            {
              "emptyDir" = {}
              "name" = "forwarder-tmpfs-tmp"
            },
            {
              "configMap" = {
                "items" = [
                  {
                    "key" = "newrelic-infra.yml"
                    "path" = "newrelic-infra.yml"
                  },
                ]
                "name" = "nri-bundle-nrk8s-agent-controlplane"
              }
              "name" = "config"
            },
          ]
        }
      }
      "updateStrategy" = {
        "rollingUpdate" = {
          "maxUnavailable" = 1
        }
        "type" = "RollingUpdate"
      }
    }
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nrk8s_controlplane" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "nri-kubernetes.yml" = <<-EOT
      interval: 30s
      namespaceSelector: {}
      controlPlane:
        retries: 3
        timeout: 10s
        enabled: true
        etcd:
          autodiscover:
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:4001
            - url: http://localhost:2381
            matchNode: true
            namespace: kube-system
            selector: tier=control-plane,component=etcd
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:4001
            matchNode: true
            namespace: kube-system
            selector: k8s-app=etcd-manager-main
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:4001
            matchNode: true
            namespace: kube-system
            selector: k8s-app=etcd
          enabled: true
        scheduler:
          autodiscover:
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10259
            matchNode: true
            namespace: kube-system
            selector: tier=control-plane,component=kube-scheduler
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10259
            matchNode: true
            namespace: kube-system
            selector: k8s-app=kube-scheduler
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10259
            matchNode: true
            namespace: openshift-kube-scheduler
            selector: app=openshift-kube-scheduler,scheduler=true
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10259
            matchNode: true
            namespace: kube-system
            selector: app=openshift-kube-scheduler,scheduler=true
          enabled: true
        controllerManager:
          autodiscover:
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10257
            matchNode: true
            namespace: kube-system
            selector: tier=control-plane,component=kube-controller-manager
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10257
            matchNode: true
            namespace: kube-system
            selector: k8s-app=kube-controller-manager
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10257
            matchNode: true
            namespace: openshift-kube-controller-manager
            selector: app=kube-controller-manager,kube-controller-manager=true
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10257
            matchNode: true
            namespace: kube-system
            selector: app=kube-controller-manager,kube-controller-manager=true
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:10257
            matchNode: true
            namespace: kube-system
            selector: app=controller-manager,controller-manager=true
          enabled: true
        apiServer:
          autodiscover:
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:8443
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:6443
            - url: http://localhost:8080
            matchNode: true
            namespace: kube-system
            selector: tier=control-plane,component=kube-apiserver
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:8443
            - url: http://localhost:8080
            matchNode: true
            namespace: kube-system
            selector: k8s-app=kube-apiserver
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:8443
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:6443
            matchNode: true
            namespace: openshift-kube-apiserver
            selector: app=openshift-kube-apiserver,apiserver=true
          - endpoints:
            - auth:
                type: bearer
              insecureSkipVerify: true
              url: https://localhost:8443
            matchNode: true
            namespace: kube-system
            selector: app=openshift-kube-apiserver,apiserver=true
          enabled: true
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-controlplane"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_newrelic_nri_bundle_nrk8s_controlplane" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-controlplane"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nrk8s_agent_ksm" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "newrelic-infra.yml" = <<-EOT
      # This is the configuration file for the infrastructure agent. See:
      # https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/configuration/infrastructure-agent-configuration-settings/
      custom_attributes:
        clusterName: marketplace-webinar
      http_server_enabled: true
      http_server_port: 8002
      is_forward_only: true
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-agent-ksm"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "deployment_newrelic_nri_bundle_nrk8s_ksm" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
        "mode" = "privileged"
      }
      "name" = "nri-bundle-nrk8s-ksm"
      "namespace" = "newrelic"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "ksm"
          "app.kubernetes.io/instance" = "nri-bundle"
          "app.kubernetes.io/name" = "newrelic-infrastructure"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "checksum/agent-config" = "28ff6dd88620f3911394c996e51a6e5d19b6fcb918a31330cffb79ccd8b29ae4"
            "checksum/license-secret" = "d0568251dac295b1dd7c0774b38855f7933808634d3e4dfe97e41e42bd6515d2"
            "checksum/nri-kubernetes" = "9270328d64de62468277f8ca286b3fa9c241fb71f13cb7297a22f1b378b324d5"
          }
          "labels" = {
            "app.kubernetes.io/component" = "ksm"
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "newrelic-infrastructure"
            "mode" = "privileged"
          }
        }
        "spec" = {
          "affinity" = {
            "podAffinity" = {
              "preferredDuringSchedulingIgnoredDuringExecution" = [
                {
                  "podAffinityTerm" = {
                    "labelSelector" = {
                      "matchLabels" = {
                        "app.kubernetes.io/name" = "kube-state-metrics"
                      }
                    }
                    "topologyKey" = "kubernetes.io/hostname"
                  }
                  "weight" = 100
                },
              ]
            }
          }
          "containers" = [
            {
              "env" = [
                {
                  "name" = "NRI_KUBERNETES_SINK_HTTP_PORT"
                  "value" = "8002"
                },
                {
                  "name" = "NRI_KUBERNETES_CLUSTERNAME"
                  "value" = "marketplace-webinar"
                },
                {
                  "name" = "NRI_KUBERNETES_VERBOSE"
                  "value" = "false"
                },
                {
                  "name" = "NRI_KUBERNETES_NODENAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
              ]
              "image" = "newrelic/nri-kubernetes:3.28.2"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "ksm"
              "resources" = {
                "limits" = {
                  "memory" = "850M"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "150M"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem" = true
                "runAsGroup" = 2000
                "runAsUser" = 1000
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/newrelic-infra/nri-kubernetes.yml"
                  "name" = "nri-kubernetes-config"
                  "subPath" = "nri-kubernetes.yml"
                },
              ]
            },
            {
              "env" = [
                {
                  "name" = "NRIA_LICENSE_KEY"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "licenseKey"
                      "name" = "nri-bundle-newrelic-infrastructure-license"
                    }
                  }
                },
                {
                  "name" = "NRIA_DNS_HOSTNAME_RESOLUTION"
                  "value" = "false"
                },
                {
                  "name" = "K8S_NODE_NAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
              ]
              "image" = "newrelic/k8s-events-forwarder:1.52.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "forwarder"
              "ports" = [
                {
                  "containerPort" = 8002
                },
              ]
              "resources" = {
                "limits" = {
                  "memory" = "850M"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "150M"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem" = true
                "runAsGroup" = 2000
                "runAsUser" = 1000
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/db/newrelic-infra/data"
                  "name" = "forwarder-tmpfs-data"
                },
                {
                  "mountPath" = "/var/db/newrelic-infra/user_data"
                  "name" = "forwarder-tmpfs-user-data"
                },
                {
                  "mountPath" = "/tmp"
                  "name" = "forwarder-tmpfs-tmp"
                },
                {
                  "mountPath" = "/etc/newrelic-infra.yml"
                  "name" = "config"
                  "subPath" = "newrelic-infra.yml"
                },
              ]
            },
          ]
          "hostNetwork" = false
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "serviceAccountName" = "nri-bundle-newrelic-infrastructure"
          "tolerations" = [
            {
              "effect" = "NoSchedule"
              "operator" = "Exists"
            },
            {
              "effect" = "NoExecute"
              "operator" = "Exists"
            },
          ]
          "volumes" = [
            {
              "configMap" = {
                "items" = [
                  {
                    "key" = "nri-kubernetes.yml"
                    "path" = "nri-kubernetes.yml"
                  },
                ]
                "name" = "nri-bundle-nrk8s-ksm"
              }
              "name" = "nri-kubernetes-config"
            },
            {
              "emptyDir" = {}
              "name" = "forwarder-tmpfs-data"
            },
            {
              "emptyDir" = {}
              "name" = "forwarder-tmpfs-user-data"
            },
            {
              "emptyDir" = {}
              "name" = "forwarder-tmpfs-tmp"
            },
            {
              "configMap" = {
                "items" = [
                  {
                    "key" = "newrelic-infra.yml"
                    "path" = "newrelic-infra.yml"
                  },
                ]
                "name" = "nri-bundle-nrk8s-agent-ksm"
              }
              "name" = "config"
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nrk8s_ksm" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "nri-kubernetes.yml" = <<-EOT
      interval: 30s
      namespaceSelector: {}
      ksm:
        enabled: true
        retries: 3
        scheme: http
        selector: app.kubernetes.io/name=kube-state-metrics
        timeout: 10s
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-ksm"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nrk8s_agent_kubelet" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "newrelic-infra.yml" = <<-EOT
      # This is the configuration file for the infrastructure agent. See:
      # https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/configuration/infrastructure-agent-configuration-settings/
      custom_attributes:
        clusterName: marketplace-webinar
      features:
        docker_enabled: false
      http_server_enabled: true
      http_server_port: 8003
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-agent-kubelet"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "daemonset_newrelic_nri_bundle_nrk8s_kubelet" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "DaemonSet"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
        "mode" = "privileged"
      }
      "name" = "nri-bundle-nrk8s-kubelet"
      "namespace" = "newrelic"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "kubelet"
          "app.kubernetes.io/instance" = "nri-bundle"
          "app.kubernetes.io/name" = "newrelic-infrastructure"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "checksum/agent-config" = "f4197b8f93b0896fa9d0e0aa75069f98f35463c645499f589bb3e34231a2ef60"
            "checksum/integrations_config" = "847325ec518e28a679a4074add1b985515064559b0db45cc73c4b39ad3413806"
            "checksum/license-secret" = "d0568251dac295b1dd7c0774b38855f7933808634d3e4dfe97e41e42bd6515d2"
            "checksum/nri-kubernetes" = "129d3f3319fcf0c3962d8d8310272d05f1ae146f3759365e75560ec44145679d"
          }
          "labels" = {
            "app.kubernetes.io/component" = "kubelet"
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "newrelic-infrastructure"
            "mode" = "privileged"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "NRI_KUBERNETES_SINK_HTTP_PORT"
                  "value" = "8003"
                },
                {
                  "name" = "NRI_KUBERNETES_CLUSTERNAME"
                  "value" = "marketplace-webinar"
                },
                {
                  "name" = "NRI_KUBERNETES_VERBOSE"
                  "value" = "false"
                },
                {
                  "name" = "NRI_KUBERNETES_NODENAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
                {
                  "name" = "NRI_KUBERNETES_NODEIP"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "status.hostIP"
                    }
                  }
                },
              ]
              "image" = "newrelic/nri-kubernetes:3.28.2"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "kubelet"
              "resources" = {
                "limits" = {
                  "memory" = "300M"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "150M"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem" = true
                "runAsGroup" = 2000
                "runAsUser" = 1000
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/newrelic-infra/nri-kubernetes.yml"
                  "name" = "nri-kubernetes-config"
                  "subPath" = "nri-kubernetes.yml"
                },
              ]
            },
            {
              "args" = [
                "newrelic-infra",
              ]
              "env" = [
                {
                  "name" = "NRIA_LICENSE_KEY"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "licenseKey"
                      "name" = "nri-bundle-newrelic-infrastructure-license"
                    }
                  }
                },
                {
                  "name" = "NRIA_OVERRIDE_HOSTNAME_SHORT"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
                {
                  "name" = "NRIA_OVERRIDE_HOSTNAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
                {
                  "name" = "NRI_KUBERNETES_NODE_NAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
                {
                  "name" = "CLUSTER_NAME"
                  "value" = "marketplace-webinar"
                },
                {
                  "name" = "NRIA_PASSTHROUGH_ENVIRONMENT"
                  "value" = "CLUSTER_NAME"
                },
                {
                  "name" = "NRIA_HOST"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "status.hostIP"
                    }
                  }
                },
              ]
              "image" = "newrelic/infrastructure-bundle:3.2.37"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "agent"
              "ports" = [
                {
                  "containerPort" = 8003
                },
              ]
              "resources" = {
                "limits" = {
                  "memory" = "300M"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "150M"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = true
                "privileged" = true
                "readOnlyRootFilesystem" = true
                "runAsGroup" = 0
                "runAsUser" = 0
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/newrelic-infra.yml"
                  "name" = "config"
                  "subPath" = "newrelic-infra.yml"
                },
                {
                  "mountPath" = "/etc/newrelic-infra/integrations.d/"
                  "name" = "nri-integrations-cfg-volume"
                },
                {
                  "mountPath" = "/dev"
                  "name" = "dev"
                },
                {
                  "mountPath" = "/run/containerd/containerd.sock"
                  "name" = "host-containerd-socket"
                },
                {
                  "mountPath" = "/var/run/docker.sock"
                  "name" = "host-docker-socket"
                },
                {
                  "mountPath" = "/var/log"
                  "name" = "log"
                },
                {
                  "mountPath" = "/host"
                  "name" = "host-volume"
                  "readOnly" = true
                },
                {
                  "mountPath" = "/var/db/newrelic-infra/data"
                  "name" = "agent-tmpfs-data"
                },
                {
                  "mountPath" = "/var/db/newrelic-infra/user_data"
                  "name" = "agent-tmpfs-user-data"
                },
                {
                  "mountPath" = "/tmp"
                  "name" = "agent-tmpfs-tmp"
                },
              ]
            },
          ]
          "hostNetwork" = false
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "serviceAccountName" = "nri-bundle-newrelic-infrastructure"
          "tolerations" = [
            {
              "effect" = "NoSchedule"
              "operator" = "Exists"
            },
            {
              "effect" = "NoExecute"
              "operator" = "Exists"
            },
          ]
          "volumes" = [
            {
              "hostPath" = {
                "path" = "/dev"
              }
              "name" = "dev"
            },
            {
              "hostPath" = {
                "path" = "/run/containerd/containerd.sock"
              }
              "name" = "host-containerd-socket"
            },
            {
              "hostPath" = {
                "path" = "/var/run/docker.sock"
              }
              "name" = "host-docker-socket"
            },
            {
              "hostPath" = {
                "path" = "/var/log"
              }
              "name" = "log"
            },
            {
              "hostPath" = {
                "path" = "/"
              }
              "name" = "host-volume"
            },
            {
              "emptyDir" = {}
              "name" = "agent-tmpfs-data"
            },
            {
              "emptyDir" = {}
              "name" = "agent-tmpfs-user-data"
            },
            {
              "emptyDir" = {}
              "name" = "agent-tmpfs-tmp"
            },
            {
              "configMap" = {
                "items" = [
                  {
                    "key" = "nri-kubernetes.yml"
                    "path" = "nri-kubernetes.yml"
                  },
                ]
                "name" = "nri-bundle-nrk8s-kubelet"
              }
              "name" = "nri-kubernetes-config"
            },
            {
              "configMap" = {
                "items" = [
                  {
                    "key" = "newrelic-infra.yml"
                    "path" = "newrelic-infra.yml"
                  },
                ]
                "name" = "nri-bundle-nrk8s-agent-kubelet"
              }
              "name" = "config"
            },
            {
              "configMap" = {
                "name" = "nri-bundle-nrk8s-integrations-cfg"
              }
              "name" = "nri-integrations-cfg-volume"
            },
          ]
        }
      }
      "updateStrategy" = {
        "rollingUpdate" = {
          "maxUnavailable" = 1
        }
        "type" = "RollingUpdate"
      }
    }
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nrk8s_integrations_cfg" {
  manifest = {
    "apiVersion" = "v1"
    "data" = null
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-integrations-cfg"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nrk8s_kubelet" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "nri-kubernetes.yml" = <<-EOT
      interval: 30s
      namespaceSelector: {}
      kubelet:
        enabled: true
        retries: 3
        scraperMaxReruns: 4
        timeout: 10s
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-nrk8s-kubelet"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "secret_newrelic_nri_bundle_newrelic_infrastructure_license" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "licenseKey" = var.nr_license_key
    }
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-newrelic-infrastructure-license"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_newrelic_nri_bundle_newrelic_infrastructure" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-infrastructure"
        "app.kubernetes.io/version" = "3.28.2"
        "helm.sh/chart" = "newrelic-infrastructure-3.33.2"
      }
      "name" = "nri-bundle-newrelic-infrastructure"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "clusterrole_nri_bundle_newrelic_logging" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "newrelic-logging"
        "app.kubernetes.io/name" = "newrelic-logging"
        "chart" = "newrelic-logging-1.21.2"
        "release" = "nri-bundle"
      }
      "name" = "nri-bundle-newrelic-logging"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "namespaces",
          "pods",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_nri_bundle_newrelic_logging" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "newrelic-logging"
        "app.kubernetes.io/name" = "newrelic-logging"
        "chart" = "newrelic-logging-1.21.2"
        "release" = "nri-bundle"
      }
      "name" = "nri-bundle-newrelic-logging"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "nri-bundle-newrelic-logging"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-newrelic-logging"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_newrelic_logging_fluent_bit_config" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "fluent-bit.conf" = <<-EOT
      [SERVICE]
          Flush         1
          Log_Level     $${LOG_LEVEL}
          Daemon        off
          Parsers_File  parsers.conf
          HTTP_Server   On
          HTTP_Listen   0.0.0.0
          HTTP_Port     2020
      
      [INPUT]
          Name              tail
          Alias             pod-logs-tailer
          Tag               kube.*
          Path              $${PATH}
          multiline.parser  $${LOG_PARSER}
          DB                $${FB_DB}
          Mem_Buf_Limit     7MB
          Skip_Long_Lines   On
          Refresh_Interval  10
      
      [FILTER]
          Name           kubernetes
          Match          kube.*
          Alias          kubernetes-enricher
          # We need the full DNS suffix as Windows only supports resolving names with this suffix
          # See: https://kubernetes.io/docs/setup/production-environment/windows/intro-windows-in-kubernetes/#dns-limitations
          Kube_URL       https://kubernetes.default.svc.cluster.local:443
          Buffer_Size    $${K8S_BUFFER_SIZE}
          K8S-Logging.Exclude $${K8S_LOGGING_EXCLUDE}
          Labels         Off
          Annotations    Off
      
      [FILTER]
          Name           nest
          Match          *
          Alias          kubernetes-attribute-lifter
          Operation      lift
          Nested_under   kubernetes
      
      [FILTER]
          Name           record_modifier
          Match          *
          Alias          node-attributes-enricher-filter
          Record         cluster_name $${CLUSTER_NAME}
          Allowlist_key  container_name
          Allowlist_key  namespace_name
          Allowlist_key  pod_name
          Allowlist_key  stream
          Allowlist_key  message
          Allowlist_key  log
      
      [OUTPUT]
          Name           newrelic
          Match          *
          Alias          newrelic-logs-forwarder
          licenseKey     $${LICENSE_KEY}
          endpoint       $${ENDPOINT}
          lowDataMode    $${LOW_DATA_MODE}
          sendMetrics    $${SEND_OUTPUT_PLUGIN_METRICS}
          Retry_Limit    $${RETRY_LIMIT}
      
      EOT
      "parsers.conf" = ""
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app" = "newrelic-logging"
        "app.kubernetes.io/name" = "newrelic-logging"
        "chart" = "newrelic-logging-1.21.2"
        "release" = "nri-bundle"
      }
      "name" = "nri-bundle-newrelic-logging-fluent-bit-config"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "daemonset_newrelic_nri_bundle_newrelic_logging" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "DaemonSet"
    "metadata" = {
      "annotations" = null
      "labels" = {
        "app" = "newrelic-logging"
        "app.kubernetes.io/name" = "newrelic-logging"
        "chart" = "newrelic-logging-1.21.2"
        "release" = "nri-bundle"
      }
      "name" = "nri-bundle-newrelic-logging"
      "namespace" = "newrelic"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "newrelic-logging"
          "release" = "nri-bundle"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "checksum/fluent-bit-config" = "0afd5ea97880b3b90fc6321a7baf9baacd4440e973c50c8ffdc56b7cca1991a3"
          }
          "labels" = {
            "app" = "newrelic-logging"
            "app.kubernetes.io/name" = "newrelic-logging"
            "kubernetes.io/os" = "linux"
            "release" = "nri-bundle"
          }
        }
        "spec" = {
          "containers" = [
            {
              "command" = [
                "/fluent-bit/bin/fluent-bit",
                "-c",
                "/fluent-bit/etc/fluent-bit.conf",
                "-e",
                "/fluent-bit/bin/out_newrelic.so",
              ]
              "env" = [
                {
                  "name" = "ENDPOINT"
                  "value" = "https://log-api.newrelic.com/log/v1"
                },
                {
                  "name" = "SOURCE"
                  "value" = "k8s"
                },
                {
                  "name" = "LICENSE_KEY"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "license"
                      "name" = "nri-bundle-newrelic-logging-config"
                    }
                  }
                },
                {
                  "name" = "CLUSTER_NAME"
                  "value" = "marketplace-webinar"
                },
                {
                  "name" = "LOG_LEVEL"
                  "value" = "info"
                },
                {
                  "name" = "LOG_PARSER"
                  "value" = "cri,docker"
                },
                {
                  "name" = "FB_DB"
                  "value" = "/var/log/flb_kube.db"
                },
                {
                  "name" = "PATH"
                  "value" = "/var/log/containers/*.log"
                },
                {
                  "name" = "K8S_BUFFER_SIZE"
                  "value" = "32k"
                },
                {
                  "name" = "K8S_LOGGING_EXCLUDE"
                  "value" = "Off"
                },
                {
                  "name" = "LOW_DATA_MODE"
                  "value" = "true"
                },
                {
                  "name" = "RETRY_LIMIT"
                  "value" = "5"
                },
                {
                  "name" = "NODE_NAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
                {
                  "name" = "HOSTNAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.name"
                    }
                  }
                },
                {
                  "name" = "SEND_OUTPUT_PLUGIN_METRICS"
                  "value" = "false"
                },
                {
                  "name" = "METRICS_HOST"
                  "value" = "metric-api.newrelic.com"
                },
              ]
              "image" = "newrelic/newrelic-fluentbit-output:1.19.2"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "newrelic-logging"
              "resources" = {
                "limits" = {
                  "cpu" = "500m"
                  "memory" = "128Mi"
                }
                "requests" = {
                  "cpu" = "250m"
                  "memory" = "64Mi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/fluent-bit/etc"
                  "name" = "fluent-bit-config"
                },
                {
                  "mountPath" = "/var"
                  "name" = "logs"
                },
              ]
            },
          ]
          "dnsPolicy" = "ClusterFirstWithHostNet"
          "initContainers" = null
          "nodeSelector" = null
          "serviceAccountName" = "nri-bundle-newrelic-logging"
          "terminationGracePeriodSeconds" = 10
          "tolerations" = [
            {
              "effect" = "NoSchedule"
              "operator" = "Exists"
            },
            {
              "effect" = "NoExecute"
              "operator" = "Exists"
            },
          ]
          "volumes" = [
            {
              "configMap" = {
                "name" = "nri-bundle-newrelic-logging-fluent-bit-config"
              }
              "name" = "fluent-bit-config"
            },
            {
              "hostPath" = {
                "path" = "/var"
              }
              "name" = "logs"
            },
          ]
        }
      }
      "updateStrategy" = {
        "type" = "RollingUpdate"
      }
    }
  }
}

resource "kubernetes_manifest" "secret_newrelic_nri_bundle_newrelic_logging_config" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "license" = var.nr_license_key
    }
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "app" = "newrelic-logging"
        "app.kubernetes.io/name" = "newrelic-logging"
        "chart" = "newrelic-logging-1.21.2"
        "release" = "nri-bundle"
      }
      "name" = "nri-bundle-newrelic-logging-config"
      "namespace" = "newrelic"
    }
    "type" = "Opaque"
  }
}

resource "kubernetes_manifest" "serviceaccount_newrelic_nri_bundle_newrelic_logging" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "newrelic-logging"
        "chart" = "newrelic-logging-1.21.2"
        "release" = "nri-bundle"
      }
      "name" = "nri-bundle-newrelic-logging"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "clusterrole_nri_bundle_newrelic_prometheus_agent" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-prometheus-agent"
        "app.kubernetes.io/version" = "v2.37.8"
        "helm.sh/chart" = "newrelic-prometheus-agent-1.12.0"
      }
      "name" = "nri-bundle-newrelic-prometheus-agent"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "endpoints",
          "services",
          "pods",
          "services",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "nonResourceURLs" = [
          "/metrics",
        ]
        "verbs" = [
          "get",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_nri_bundle_newrelic_prometheus_agent" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-prometheus-agent"
        "app.kubernetes.io/version" = "v2.37.8"
        "helm.sh/chart" = "newrelic-prometheus-agent-1.12.0"
      }
      "name" = "nri-bundle-newrelic-prometheus-agent"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "nri-bundle-newrelic-prometheus-agent"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-newrelic-prometheus-agent"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_newrelic_prometheus_agent" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "config.yaml" = <<-EOT
      # Configuration for newrelic-prometheus-configurator
      newrelic_remote_write:
        extra_write_relabel_configs:
        - action: drop
          regex: kube_.+|container_.+|machine_.+|cadvisor_.+
          source_labels:
          - __name__
        - action: replace
          regex: timeseries_write_(.*)
          replacement: counter
          separator: ;
          source_labels:
          - __name__
          target_label: newrelic_metric_type
        - action: replace
          regex: sql_byte(.*)
          replacement: counter
          separator: ;
          source_labels:
          - __name__
          target_label: newrelic_metric_type
      static_targets:
        jobs:
        - extra_metric_relabel_config:
          - action: keep
            regex: prometheus_agent_active_series|prometheus_target_interval_length_seconds|prometheus_target_scrape_pool_targets|prometheus_remote_storage_samples_pending|prometheus_remote_storage_samples_in_total|prometheus_remote_storage_samples_retried_total|prometheus_agent_corruptions_total|prometheus_remote_storage_shards|prometheus_sd_kubernetes_events_total|prometheus_agent_checkpoint_creations_failed_total|prometheus_agent_checkpoint_deletions_failed_total|prometheus_remote_storage_samples_dropped_total|prometheus_remote_storage_samples_failed_total|prometheus_sd_kubernetes_http_request_total|prometheus_agent_truncate_duration_seconds_sum|prometheus_build_info|process_resident_memory_bytes|process_virtual_memory_bytes|process_cpu_seconds_total|prometheus_remote_storage_bytes_total
            source_labels:
            - __name__
          job_name: self-metrics
          skip_sharding: true
          targets:
          - localhost:9090
      common:
        external_labels:
          cluster_name: marketplace-webinar
        scrape_interval: 30s
      kubernetes:
        jobs:
        - job_name_prefix: default
          target_discovery:
            endpoints: true
            filter:
              annotations:
                prometheus.io/scrape: true
            pod: true
        - integrations_filter:
            enabled: false
          job_name_prefix: newrelic
          target_discovery:
            endpoints: true
            filter:
              annotations:
                newrelic.io/scrape: true
            pod: true
        integrations_filter:
          app_values:
          - redis
          - traefik
          - calico
          - nginx
          - coredns
          - kube-dns
          - etcd
          - cockroachdb
          - velero
          - harbor
          - argocd
          enabled: false
          source_labels:
          - app.kubernetes.io/name
          - app.newrelic.io/name
          - k8s-app
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-prometheus-agent"
        "app.kubernetes.io/version" = "v2.37.8"
        "helm.sh/chart" = "newrelic-prometheus-agent-1.12.0"
      }
      "name" = "nri-bundle-newrelic-prometheus-agent"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "secret_newrelic_nri_bundle_newrelic_prometheus_agent_license" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "licenseKey" = var.nr_license_key
    }
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-prometheus-agent"
        "app.kubernetes.io/version" = "v2.37.8"
        "helm.sh/chart" = "newrelic-prometheus-agent-1.12.0"
      }
      "name" = "nri-bundle-newrelic-prometheus-agent-license"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_newrelic_nri_bundle_newrelic_prometheus_agent" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-prometheus-agent"
        "app.kubernetes.io/version" = "v2.37.8"
        "helm.sh/chart" = "newrelic-prometheus-agent-1.12.0"
      }
      "name" = "nri-bundle-newrelic-prometheus-agent"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "statefulset_newrelic_nri_bundle_newrelic_prometheus_agent" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "StatefulSet"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "newrelic-prometheus-agent"
        "app.kubernetes.io/version" = "v2.37.8"
        "helm.sh/chart" = "newrelic-prometheus-agent-1.12.0"
      }
      "name" = "nri-bundle-newrelic-prometheus-agent"
      "namespace" = "newrelic"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/instance" = "nri-bundle"
          "app.kubernetes.io/name" = "newrelic-prometheus-agent"
        }
      }
      "serviceName" = "nri-bundle-newrelic-prometheus-agent-headless"
      "template" = {
        "metadata" = {
          "annotations" = {
            "checksum/config" = "60c8d112700ad16352ea94e503fe67c43a73741f9f3677fa1b8f5c85b43c7440"
          }
          "labels" = {
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "newrelic-prometheus-agent"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--config.file=/etc/prometheus/config/config.yaml",
                "--enable-feature=agent,expand-external-labels",
                "--storage.agent.retention.max-time=30m",
                "--storage.agent.wal-truncate-frequency=30m",
                "--storage.agent.path=/etc/prometheus/storage",
              ]
              "image" = "quay.io/prometheus/prometheus:v2.37.8"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/-/healthy"
                  "port" = 9090
                  "scheme" = "HTTP"
                }
                "initialDelaySeconds" = 10
                "periodSeconds" = 15
                "successThreshold" = 1
                "timeoutSeconds" = 10
              }
              "name" = "prometheus"
              "ports" = [
                {
                  "containerPort" = 9090
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/-/ready"
                  "port" = 9090
                  "scheme" = "HTTP"
                }
                "initialDelaySeconds" = 10
                "periodSeconds" = 5
                "successThreshold" = 1
                "timeoutSeconds" = 4
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/prometheus/config"
                  "name" = "prometheus-config"
                },
                {
                  "mountPath" = "/etc/prometheus/storage"
                  "name" = "prometheus-storage"
                },
              ]
            },
          ]
          "hostNetwork" = false
          "initContainers" = [
            {
              "args" = [
                "--input=/etc/configurator/config.yaml",
                "--output=/etc/prometheus/config/config.yaml",
              ]
              "env" = [
                {
                  "name" = "NR_PROM_DATA_SOURCE_NAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.name"
                    }
                  }
                },
                {
                  "name" = "NR_PROM_LICENSE_KEY"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "licenseKey"
                      "name" = "nri-bundle-newrelic-prometheus-agent-license"
                    }
                  }
                },
                {
                  "name" = "NR_PROM_CHART_VERSION"
                  "value" = "1.12.0"
                },
              ]
              "image" = "newrelic/newrelic-prometheus-configurator:1.15.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "configurator"
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/configurator/"
                  "name" = "configurator-config"
                },
                {
                  "mountPath" = "/etc/prometheus/config"
                  "name" = "prometheus-config"
                },
              ]
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "serviceAccountName" = "nri-bundle-newrelic-prometheus-agent"
          "volumes" = [
            {
              "configMap" = {
                "name" = "nri-bundle-newrelic-prometheus-agent"
              }
              "name" = "configurator-config"
            },
            {
              "emptyDir" = {}
              "name" = "prometheus-config"
            },
            {
              "emptyDir" = {}
              "name" = "prometheus-storage"
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nri_kube_events_agent_config" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "newrelic-infra.yml" = <<-EOT
      is_forward_only: true
      http_server_enabled: true
      http_server_port: 8001
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-kube-events"
        "app.kubernetes.io/version" = "2.9.4"
        "helm.sh/chart" = "nri-kube-events-3.9.4"
      }
      "name" = "nri-bundle-nri-kube-events-agent-config"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "clusterrole_nri_bundle_nri_kube_events" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-kube-events"
        "app.kubernetes.io/version" = "2.9.4"
        "helm.sh/chart" = "nri-kube-events-3.9.4"
      }
      "name" = "nri-bundle-nri-kube-events"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
          "namespaces",
          "nodes",
          "jobs",
          "persistentvolumes",
          "persistentvolumeclaims",
          "pods",
          "services",
        ]
        "verbs" = [
          "get",
          "watch",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "daemonsets",
          "deployments",
        ]
        "verbs" = [
          "get",
          "watch",
          "list",
        ]
      },
      {
        "apiGroups" = [
          "batch",
        ]
        "resources" = [
          "cronjobs",
          "jobs",
        ]
        "verbs" = [
          "get",
          "watch",
          "list",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_nri_bundle_nri_kube_events" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-kube-events"
        "app.kubernetes.io/version" = "2.9.4"
        "helm.sh/chart" = "nri-kube-events-3.9.4"
      }
      "name" = "nri-bundle-nri-kube-events"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "nri-bundle-nri-kube-events"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-nri-kube-events"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "configmap_newrelic_nri_bundle_nri_kube_events_config" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "config.yaml" = <<-EOT
      sinks:
        - name: newRelicInfra
          config:
            agentEndpoint: http://localhost:8001/v1/data
            clusterName: marketplace-webinar
            agentHTTPTimeout: 30s
      captureDescribe: true
      describeRefresh: 24h
      captureEvents: true
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-kube-events"
        "app.kubernetes.io/version" = "2.9.4"
        "helm.sh/chart" = "nri-kube-events-3.9.4"
      }
      "name" = "nri-bundle-nri-kube-events-config"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "deployment_newrelic_nri_bundle_nri_kube_events" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "annotations" = null
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-kube-events"
        "app.kubernetes.io/version" = "2.9.4"
        "helm.sh/chart" = "nri-kube-events-3.9.4"
      }
      "name" = "nri-bundle-nri-kube-events"
      "namespace" = "newrelic"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "nri-kube-events"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "nri-kube-events"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "-config",
                "/app/config/config.yaml",
                "-loglevel",
                "debug",
              ]
              "image" = "newrelic/nri-kube-events:2.9.4"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "kube-events"
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "privileged" = false
                "readOnlyRootFilesystem" = true
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/app/config"
                  "name" = "config-volume"
                },
              ]
            },
            {
              "env" = [
                {
                  "name" = "NRIA_LICENSE_KEY"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "licenseKey"
                      "name" = "nri-bundle-nri-kube-events-license"
                    }
                  }
                },
                {
                  "name" = "NRIA_OVERRIDE_HOSTNAME_SHORT"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "spec.nodeName"
                    }
                  }
                },
              ]
              "image" = "newrelic/k8s-events-forwarder:1.52.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "forwarder"
              "ports" = [
                {
                  "containerPort" = 8001
                },
              ]
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "privileged" = false
                "readOnlyRootFilesystem" = true
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/db/newrelic-infra/data"
                  "name" = "tmpfs-data"
                },
                {
                  "mountPath" = "/var/db/newrelic-infra/user_data"
                  "name" = "tmpfs-user-data"
                },
                {
                  "mountPath" = "/tmp"
                  "name" = "tmpfs-tmp"
                },
                {
                  "mountPath" = "/etc/newrelic-infra.yml"
                  "name" = "config"
                  "subPath" = "newrelic-infra.yml"
                },
              ]
            },
          ]
          "hostNetwork" = false
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "runAsNonRoot" = true
            "runAsUser" = 1000
          }
          "serviceAccountName" = "nri-bundle-nri-kube-events"
          "volumes" = [
            {
              "configMap" = {
                "items" = [
                  {
                    "key" = "newrelic-infra.yml"
                    "path" = "newrelic-infra.yml"
                  },
                ]
                "name" = "nri-bundle-nri-kube-events-agent-config"
              }
              "name" = "config"
            },
            {
              "configMap" = {
                "name" = "nri-bundle-nri-kube-events-config"
              }
              "name" = "config-volume"
            },
            {
              "emptyDir" = {}
              "name" = "tmpfs-data"
            },
            {
              "emptyDir" = {}
              "name" = "tmpfs-user-data"
            },
            {
              "emptyDir" = {}
              "name" = "tmpfs-tmp"
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "secret_newrelic_nri_bundle_nri_kube_events_license" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "licenseKey" = var.nr_license_key
    }
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-kube-events"
        "app.kubernetes.io/version" = "2.9.4"
        "helm.sh/chart" = "nri-kube-events-3.9.4"
      }
      "name" = "nri-bundle-nri-kube-events-license"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_newrelic_nri_bundle_nri_kube_events" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "annotations" = null
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-kube-events"
        "app.kubernetes.io/version" = "2.9.4"
        "helm.sh/chart" = "nri-kube-events-3.9.4"
      }
      "name" = "nri-bundle-nri-kube-events"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "clusterrole_nri_bundle_nri_metadata_injection_admission" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "annotations" = {
        "helm.sh/hook" = "pre-install,pre-upgrade,post-install,post-upgrade"
        "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
      }
      "labels" = {
        "app" = "nri-metadata-injection-admission"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection-admission"
    }
    "rules" = [
      {
        "apiGroups" = [
          "admissionregistration.k8s.io",
        ]
        "resources" = [
          "mutatingwebhookconfigurations",
        ]
        "verbs" = [
          "get",
          "update",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_nri_bundle_nri_metadata_injection_admission" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "annotations" = {
        "helm.sh/hook" = "pre-install,pre-upgrade,post-install,post-upgrade"
        "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
      }
      "labels" = {
        "app" = "nri-metadata-injection-admission"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection-admission"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "nri-bundle-nri-metadata-injection-admission"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-nri-metadata-injection-admission"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "job_newrelic_nri_bundle_nri_metadata_injection_admission_create" {
  manifest = {
    "apiVersion" = "batch/v1"
    "kind" = "Job"
    "metadata" = {
      "annotations" = {
        "helm.sh/hook" = "pre-install,pre-upgrade"
        "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
      }
      "labels" = {
        "app" = "nri-metadata-injection-admission-create"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection-admission-create"
      "namespace" = "newrelic"
    }
    "spec" = {
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "nri-metadata-injection-admission-create"
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "nri-metadata-injection"
            "app.kubernetes.io/version" = "1.26.4"
            "helm.sh/chart" = "nri-metadata-injection-4.18.4"
          }
          "name" = "nri-bundle-nri-metadata-injection-admission-create"
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "create",
                "--host=nri-bundle-nri-metadata-injection,nri-bundle-nri-metadata-injection.newrelic.svc",
                "--namespace=newrelic",
                "--secret-name=nri-bundle-nri-metadata-injection-admission",
                "--cert-name=tls.crt",
                "--key-name=tls.key",
              ]
              "image" = "registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.3.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "create"
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "restartPolicy" = "OnFailure"
          "securityContext" = {
            "runAsGroup" = 2000
            "runAsNonRoot" = true
            "runAsUser" = 2000
          }
          "serviceAccountName" = "nri-bundle-nri-metadata-injection-admission"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "job_newrelic_nri_bundle_nri_metadata_injection_admission_patch" {
  manifest = {
    "apiVersion" = "batch/v1"
    "kind" = "Job"
    "metadata" = {
      "annotations" = {
        "helm.sh/hook" = "post-install,post-upgrade"
        "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
      }
      "labels" = {
        "app" = "nri-metadata-injection-admission-patch"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection-admission-patch"
      "namespace" = "newrelic"
    }
    "spec" = {
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "nri-metadata-injection-admission-patch"
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "nri-metadata-injection"
            "app.kubernetes.io/version" = "1.26.4"
            "helm.sh/chart" = "nri-metadata-injection-4.18.4"
          }
          "name" = "nri-bundle-nri-metadata-injection-admission-patch"
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "patch",
                "--webhook-name=nri-bundle-nri-metadata-injection",
                "--namespace=newrelic",
                "--secret-name=nri-bundle-nri-metadata-injection-admission",
                "--patch-failure-policy=Ignore",
                "--patch-validating=false",
              ]
              "image" = "registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.3.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "patch"
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "restartPolicy" = "OnFailure"
          "securityContext" = {
            "runAsGroup" = 2000
            "runAsNonRoot" = true
            "runAsUser" = 2000
          }
          "serviceAccountName" = "nri-bundle-nri-metadata-injection-admission"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "role_newrelic_nri_bundle_nri_metadata_injection_admission" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "annotations" = {
        "helm.sh/hook" = "pre-install,pre-upgrade,post-install,post-upgrade"
        "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
      }
      "labels" = {
        "app" = "nri-metadata-injection-admission"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection-admission"
      "namespace" = "newrelic"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "create",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_newrelic_nri_bundle_nri_metadata_injection_admission" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "annotations" = {
        "helm.sh/hook" = "pre-install,pre-upgrade,post-install,post-upgrade"
        "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
      }
      "labels" = {
        "app" = "nri-metadata-injection-admission"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection-admission"
      "namespace" = "newrelic"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "nri-bundle-nri-metadata-injection-admission"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "nri-bundle-nri-metadata-injection-admission"
        "namespace" = "newrelic"
      },
    ]
  }
}

resource "kubernetes_manifest" "serviceaccount_newrelic_nri_bundle_nri_metadata_injection_admission" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "annotations" = {
        "helm.sh/hook" = "pre-install,pre-upgrade,post-install,post-upgrade"
        "helm.sh/hook-delete-policy" = "before-hook-creation,hook-succeeded"
      }
      "labels" = {
        "app" = "nri-metadata-injection-admission"
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection-admission"
      "namespace" = "newrelic"
    }
  }
}

resource "kubernetes_manifest" "mutatingwebhookconfiguration_nri_bundle_nri_metadata_injection" {
  manifest = {
    "apiVersion" = "admissionregistration.k8s.io/v1"
    "kind" = "MutatingWebhookConfiguration"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection"
    }
    "webhooks" = [
      {
        "admissionReviewVersions" = [
          "v1",
          "v1beta1",
        ]
        "clientConfig" = {
          "caBundle" = ""
          "service" = {
            "name" = "nri-bundle-nri-metadata-injection"
            "namespace" = "newrelic"
            "path" = "/mutate"
          }
        }
        "failurePolicy" = "Ignore"
        "name" = "metadata-injection.newrelic.com"
        "rules" = [
          {
            "apiGroups" = [
              "",
            ]
            "apiVersions" = [
              "v1",
            ]
            "operations" = [
              "CREATE",
            ]
            "resources" = [
              "pods",
            ]
          },
        ]
        "sideEffects" = "None"
        "timeoutSeconds" = 28
      },
    ]
  }
}

resource "kubernetes_manifest" "deployment_newrelic_nri_bundle_nri_metadata_injection" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection"
      "namespace" = "newrelic"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "nri-metadata-injection"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/instance" = "nri-bundle"
            "app.kubernetes.io/name" = "nri-metadata-injection"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "clusterName"
                  "value" = "marketplace-webinar"
                },
              ]
              "image" = "newrelic/k8s-metadata-injection:1.26.4"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "nri-metadata-injection"
              "ports" = [
                {
                  "containerPort" = 8443
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/health"
                  "port" = 8080
                }
                "initialDelaySeconds" = 1
                "periodSeconds" = 1
              }
              "resources" = {
                "limits" = {
                  "memory" = "80M"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "30M"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/tls-key-cert-pair"
                  "name" = "tls-key-cert-pair"
                },
              ]
            },
          ]
          "hostNetwork" = false
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "fsGroup" = 1001
            "runAsGroup" = 1001
            "runAsUser" = 1001
          }
          "volumes" = [
            {
              "name" = "tls-key-cert-pair"
              "secret" = {
                "secretName" = "nri-bundle-nri-metadata-injection-admission"
              }
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_newrelic_nri_bundle_nri_metadata_injection" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
        "app.kubernetes.io/version" = "1.26.4"
        "helm.sh/chart" = "nri-metadata-injection-4.18.4"
      }
      "name" = "nri-bundle-nri-metadata-injection"
      "namespace" = "newrelic"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 443
          "targetPort" = 8443
        },
      ]
      "selector" = {
        "app.kubernetes.io/instance" = "nri-bundle"
        "app.kubernetes.io/name" = "nri-metadata-injection"
      }
    }
  }
}
