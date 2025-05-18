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

