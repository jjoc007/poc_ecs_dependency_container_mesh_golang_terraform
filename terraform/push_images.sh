export AWS_ACCESS_KEY_ID="change me"
export AWS_SECRET_ACCESS_KEY="change me"
export AWS_SESSION_TOKEN="change me"

#login
aws ecr get-login --registry-ids 123456789 --no-include-email

#generate tags
docker tag poc-main-service aws_account_id.dkr.ecr.region.amazonaws.com/poc-main-service
docker tag poc-transformer-service aws_account_id.dkr.ecr.region.amazonaws.com/poc-transformer-service

#push images
docker push aws_account_id.dkr.ecr.region.amazonaws.com/poc-main-service
docker push aws_account_id.dkr.ecr.region.amazonaws.com/poc-transformer-service