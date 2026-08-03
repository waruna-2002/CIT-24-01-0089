#!/bin/bash
echo "Stopping app..."

docker stop web-app redis-db
docker rm web-app redis-db

echo "App stopped successfully (Data preserved in persistent volume)."