variable "k8s_admin_role_arn" {
    type = string
    description = "Role arn to be provided cluster admin access"
}

variable "cluster_version" {
    type = string
    default = "1.28"
    description = "K8S version"
    validation {
    condition     = contains(["1.29", "1.28"], var.cluster_version)
    error_message = "Cluster version should be aither 1.29 or 1.28"
  }
  
}
