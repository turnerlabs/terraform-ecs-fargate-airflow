data "template_file" "dag" {
  template = file("${path.module}/dag.tpl")

  vars = {
    app                 = var.app
    environment         = var.environment
    schedule_expression = var.schedule_expression
    security_group      = aws_security_group.nsg_task.id
    subnets             = jsonencode(split(",", var.private_subnets))
  }
}

resource "local_file" "dag" {
  filename = "${path.module}/dags/${local.namespace}.py"
  content  = data.template_file.dag.rendered
}

