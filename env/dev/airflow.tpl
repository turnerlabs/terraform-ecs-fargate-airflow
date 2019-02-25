#! /bin/bash
set -e

# build image
docker-compose build

# push image to ECR repo
export AWS_PROFILE=${profile}
export AWS_DEFAULT_REGION=${region}
login=$(aws ecr get-login --no-include-email) && eval "$login"
docker-compose push

# deploy image and env vars
REVISION=$(fargate task register -f docker-compose.yml)

# deploy dag to airflow
aws s3 cp ./dags/${dag}.py ${airflow_dag_s3_bucket}