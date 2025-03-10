#!/bin/bash
# Update system and install Docker
sudo yum update -y
sudo yum install docker -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

ENVIRONMENT="dev"
DB_USERNAME="cardsisland_web"
DB_PASSWORD="cardsisland_web"

# Run PostgreSQL container with restart policy
sudo docker run --name postgres-container \
  -e POSTGRES_USER=$DB_USERNAME \
  -e POSTGRES_PASSWORD=$DB_PASSWORD \
  -e POSTGRES_DB=ci-database-$ENVIRONMENT \
  -p 5432:5432 \
  -d --restart always postgres

sudo systemctl restart docker