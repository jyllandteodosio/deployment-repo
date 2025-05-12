# Docker Compose Deployment

This repository manages the deployment of multiple apps on a DigitalOcean droplet using Docker Compose and GitHub Actions.

## What's Inside

deployment-repo/
├── .github/
│   └── workflows/
│       └── deploy.yml          # Deploys the stack
├── docker-compose.yml          # Defines all app services
├── nginx/                      # Nginx reverse proxy config
│   └── nginx.conf
│   └── conf.d/
│       └── portfolio.conf
│       └── taskaru.conf
├── scripts/
│   └── deploy.sh               # Deployment script
└── README.md                   # This file


## Quick Setup

1. **Droplet:** Get a DigitalOcean droplet with Docker and Docker Compose plugin.

2. **SSH:** Set up SSH access for CI/CD (dedicated key recommended).

3. **SSL:** Install Certbot on droplet for SSL certs (`/etc/letsencrypt/`).

4. **Deploy Dir:** Create `/opt/docker/` on your droplet: `sudo mkdir -p /opt/docker/`.

5. **Secrets:** Add `SSH_HOST`, `SSH_USER`, `SSH_PRIVATE_KEY` to GitHub repo secrets.

## How Deployment Works

1. You push app code (e.g., portfolio repo).

2. App workflow builds image & pushes to Docker Hub.

3. You push changes to *this* repo (`docker-compose.yml`, Nginx config).

4. This repo's `deploy.yml` workflow runs.

5. Workflow copies files to droplet (`/opt/docker/`).

6. Workflow runs `deploy.sh` on droplet.

7. `deploy.sh` pulls latest images (`docker compose pull`) and starts/updates containers (`docker compose up -d`).

## Add a New App

1. Create app Dockerfile.

2. Set up app CI workflow (build & push image).

3. Update `docker-compose.yml` in *this* repo (add service).

4. Add Nginx config file (`nginx/conf.d/newapp.conf`) in *this* repo.

5. Commit changes in *this* repo & push to `main`.

## Need Help?

* **Workflow:** Check GitHub Actions logs for `deploy.yml`.

* **Containers:** SSH to droplet, `cd /opt/docker/`, use `docker compose ps` and `docker compose logs <service_name>`.

* **HTTPS:** Check droplet firewall (ufw), DigitalOcean Cloud Firewalls, Nginx container logs, and certificate file permissions on droplet.
