#!/bin/bash
echo "Removing app..."

# Stop and remove containers
docker stop web-app redis-db 2>/dev/null
docker rm web-app redis-db 2>/dev/null

# Remove network and volume
docker network rm app-net 2>/dev/null
docker volume rm redis-data 2>/dev/null

# Remove local image
docker rmi my-web-app 2>/dev/null
rm -f Dockerfile app.py

echo "Removed app completely."