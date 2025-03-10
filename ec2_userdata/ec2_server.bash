#!/bin/bash
# Update system and install Docker
sudo yum update -y
sudo yum install docker -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

ENVIRONMENT="dev"
IMAGE_NAME="frekkanzer2/cards-island-dev"
IMAGE_TAG="latest"
DB_USERNAME="cardsisland_web"
DB_PASSWORD="cardsisland_web"
PORT="80"
DB_HOST="cidb.lab.cna.stormreply.com"

sudo docker pull $IMAGE_NAME:$IMAGE_TAG

sudo docker run -d -p $PORT:3000 \
  --name cards-island-$ENVIRONMENT-server \
  -e DB_USERNAME=$DB_USERNAME \
  -e DB_PASSWORD=$DB_PASSWORD \
  -e DB_NAME=ci-database-$ENVIRONMENT \
  -e DB_HOST=$DB_HOST \
  -d --restart always $IMAGE_NAME

sudo systemctl restart docker