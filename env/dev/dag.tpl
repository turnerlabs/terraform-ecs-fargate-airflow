from airflow import DAG
from datetime import datetime, timedelta
from fargate_ecs_plugin import FargateEcsOperator

namespace = '${app}-${environment}'

default_args = {
    'owner': 'airflow',
    'aws_conn_id': '',
    'start_date': datetime(2018, 8, 12),
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
    'cluster': namespace,
    'task_definition': namespace,
    'log_group_name': '/fargate/task/' + namespace,
    'subnets': ${subnets},
    'securityGroups': ['${security_group}']
}

dag = DAG(namespace, catchup=False, default_args=default_args,
          schedule_interval='${schedule_expression}',)

task1 = FargateEcsOperator(
    dag=dag,
    task_id=namespace+'-task1',
    overrides={
        'containerOverrides': [
            {
                'name': 'app',
                'command': [
                    'python',
                    'main.py'
                ]
            }
        ]
    }
)
