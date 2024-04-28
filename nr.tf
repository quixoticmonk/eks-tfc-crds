resource "newrelic_one_dashboard_json" "k8s_dash" {
     json = templatefile("json/infra_dashboard.tftpl",{account_id=var.nr_account_id})
}

resource "newrelic_one_dashboard_json" "k8s_logs" {
     json = templatefile("json/log_ingestion.tftpl",{account_id=var.nr_account_id})
}