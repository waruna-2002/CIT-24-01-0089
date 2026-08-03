# Docker Web Application Assignment

## Deployment Requirements
- Docker Desktop (with Linux Containers mode)
- Git Bash / Terminal

## Application Description
This is a multi-container Docker web application using Python (Flask) for the frontend service and Redis for maintaining persistence count state.

## Network and Volume Details
- **Network**: `app-net` (Bridge network for container communication)
- **Volume**: `redis-data` (Persistent named volume attached to `/data` in Redis)

## Container Configuration
1. **web-app**: Custom built Flask image, runs on Port 5000, connects to `redis-db`.
2. **redis-db**: Official `redis:alpine` image, runs internally on Port 6379 with persistence enabled (`--appendonly yes`).

## Instructions
Run the following bash scripts in order:

```bash
# 1. Prepare App Resources
./prepare-app.sh

# 2. Start Application
./start-app.sh

# Access at http://localhost:5000

# 3. Stop Application (Data Preserved)
./stop-app.sh

# 4. Remove All Application Resources
./remove-app.sh