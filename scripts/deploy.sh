#!/bin/bash

# This script is executed on the DigitalOcean droplet by the GitHub Actions workflow.
# It manages the Docker Compose stack.

# Define the base deployment directory on the droplet.
# This should match the 'target' directory used in the scp-action in your workflow.
DEPLOY_BASE_DIR="/opt/docker" # <-- Make sure this path exists on your droplet

# Define the path for the temporary environment file (still needed for docker compose)
ENV_FILE="${DEPLOY_BASE_DIR}/.env.generated"

# Navigate to the directory containing the docker-compose.yml file.
# Adjust this path if your compose file is in a subdirectory within the base deploy directory.
cd ${DEPLOY_BASE_DIR} || { echo "Error: Deployment directory ${DEPLOY_BASE_DIR} not found."; exit 1; }

echo "Navigated to deployment directory: ${PWD}"

# Pull the latest Docker images defined in the compose file (for services not built locally).
# This ensures you are running the most recent versions of your application images
# from Docker Hub and official images like databases.
echo "Pulling latest Docker images..."
# Use the generated env file for the pull command as well, though often not strictly needed for pull
docker compose --env-file "${ENV_FILE}" pull || { echo "Error: Failed to pull Docker images."; exit 1; }

# Build the Nginx image from the local Dockerfile.
# This ensures the latest Nginx configuration is included.
# NOTE: Ensure your Nginx Dockerfile is located at ./nginx/Dockerfile
#       relative to your docker-compose.yml file on the droplet.
echo "Building Nginx image..."
# Use the generated env file for the build command if the Dockerfile uses ARGs
docker compose --env-file "${ENV_FILE}" build nginx || { echo "Error: Failed to build Nginx image."; exit 1; }


# Bring up the services defined in the compose file.
# -d: run in detached mode (in the background)
# --remove-orphans: remove containers for services that are no longer defined in the compose file
# --force-recreate: Recreate containers even if their configuration hasn't changed (useful for ensuring latest image is used) - Optional, remove if you want faster deployments when only code changes
echo "Bringing up Docker Compose stack..."
# Use the generated env file to pass variables to the running containers
docker compose --env-file "${ENV_FILE}" up -d --remove-orphans --pull # --force-recreate || { echo "Error: Failed to bring up Docker Compose stack."; exit 1; }

# Optional: Clean up the temporary environment file
# echo "Cleaning up temporary environment file..."
# rm "${ENV_FILE}"

# Optional: Clean up old unused Docker images to save disk space.
# echo "Cleaning up old Docker images..."
# docker image prune -f

echo "Deployment complete!"

exit 0 # Exit successfully
