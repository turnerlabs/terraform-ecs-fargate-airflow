# grant airflow host role access to fargate
resource "aws_iam_role_policy" "airflow_policy" {
  name = "airflow_policy_${var.app}-${var.environment}"
  role = var.airflow_role

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": "ecs:RunTask",
      "Resource": [
        "arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:task-definition/${aws_ecs_task_definition.app.family}:*",
        "arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:task-definition/${aws_ecs_task_definition.app.family}"
        ]
      },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": "ecs:DescribeTasks",
      "Resource": [
        "arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:task/*"
      ]
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": "logs:GetLogEvents",
      "Resource": [
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.logs.id}:log-stream:/fargate/app/*",
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.logs.id}:log-stream:fargate/app/*"
      ]
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": [
        "${aws_iam_role.app_role.arn}",
        "${aws_iam_role.ecsTaskExecutionRole.arn}"
      ]
    }
  ]
} 
EOF

}

