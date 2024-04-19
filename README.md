# Docker Compose files 🛳️

## Getting Started
This repository contains a Docker Compose file for setting up some utils.

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites

- Docker
```bash
brew install docker
```
- Docker Compose
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker compose version
```
- Colima
```bash
brew install colima
```

## Installation
1. Clone the repository
```bash
git clone git@github.com:vjsantojaca/docker-octo-spork.git
```
2. Navigate to the directory of the docker compose that you want to use
```bash
cd postgres
```
3. Start the docker compose
```bash
docker-compose up -d
```

## Postgres




## Contributing
Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.

## License
This project is licensed under the GNU GENERAL PUBLIC LICENSE Version 3 - see the [LICENSE](LICENSE) file for details

