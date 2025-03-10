#!/bin/bash
# Update system and install Docker
sudo yum update -y
sudo yum install docker -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Run PostgreSQL container with restart policy
sudo docker run --name postgres-container \
  -e POSTGRES_USER=cardsisland_web \
  -e POSTGRES_PASSWORD=cardsisland_web \
  -e POSTGRES_DB=database \
  -p 5432:5432 \
  -d --restart always postgres

sudo systemctl restart docker