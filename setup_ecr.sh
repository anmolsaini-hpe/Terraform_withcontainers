

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 843126734353.dkr.ecr.us-east-1.amazonaws.com

ECR_APPLICATION_REPO_NAME=django-app

REGION=us-east-1

ECR_APPLICATION_TIER_REPO=$(aws ecr describe-repositories --repository-names ${ECR_APPLICATION_REPO_NAME} --region ${REGION} --output json | jq -r '.repositories[0].repositoryUri')

docker build --platform=linux/amd64 -t django-app .

docker tag django-app:latest $ECR_APPLICATION_TIER_REPO:latest

echo "################### Pushing application tier image ###################"

docker push $ECR_APPLICATION_TIER_REPO:latest