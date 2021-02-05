#!/bin/bash

AWS_ACCOUNT_ID=401962582868

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
docker tag  coinbase-monitor:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/coinbase-monitor:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/coinbase-monitor:latest
