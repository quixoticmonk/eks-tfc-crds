check "health_check" {
  data "http" "check_url" {
    url = "https://www.terraform.io"
  }

  assert {
    condition = data.http.terraform_io.status_code == 200
    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
  }
}


check "cluster_status" {

  assert {
    condition = module.eks.cluster_status== "ACTIVE"
    error_message = "The cluster status is ${module.eks.cluster_status}"
  }
}

check "cluster_version" {

  assert {
    condition = module.eks.cluster_version== var.cluster_version
    error_message = "The cluster version is ${module.eks.cluster_version}"
  }
}
