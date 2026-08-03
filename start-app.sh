#!/bin/bash
echo "Running app..."

# 1. Database Service Container (Redis) run karanna - Volume mounted
docker run -d \
  --name redis-db \
  --network app-net \
  --restart always \
  -v redis-data:/data \
  redis:alpine redis-server --appendonly yes

# 2. Web App Service Container run karanna
docker run -d \
  --name web-app \
  --network app-net \
  --restart always \
  -p 5000:5000 \
  my-web-app

echo "The app is available at http://localhost:5000"