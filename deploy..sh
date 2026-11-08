#!/bin/bash
set -e

# Move to project directory
cd /var/www/bulk-carrier-erp

# Pull latest code
git pull origin staging

# Build backend Docker image
docker build -t bulk-carrier-backend:prod ./backend

# Build frontend Docker image
docker build --no-cache -t bulk-carrier-frontend:prod ./frontend

# Stop existing containers (if running)
docker compose down

# Start containers with updated images
docker compose up -d --build

# Fix permissions for shared volumes (backend storage/cache, frontend dist)
sudo chown -R www-data:www-data ./backend/storage ./backend/bootstrap/cache ./frontend/dist

# Reload nginx proxy
sudo systemctl reload nginx

echo "Deployment complete!"