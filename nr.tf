resource "newrelic_one_dashboard_json" "k8s_dash" {
     json = templatefile("${path.module}/json/infra_dashboard.json",{account_id=var.nr_account_id})
}

resource "newrelic_one_dashboard_json" "k8s_logs" {
     json = templatefile("${path.module}/json/log_ingestion.tftpl",{account_id=var.nr_account_id})
}