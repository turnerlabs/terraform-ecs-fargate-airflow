data "template_file" "airflow" {
  template = file("${path.module}/airflow.tpl")

  vars = {
    profile               = var.aws_profile
    region                = var.region
    dag                   = local.namespace
    airflow_dag_s3_bucket = var.airflow_dag_s3_bucket
  }
}

resource "local_file" "airflow" {
  filename = "${path.module}/deploy-airflow.sh"
  content  = data.template_file.airflow.rendered
}

