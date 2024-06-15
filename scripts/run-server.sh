# /bin/bash

# Make sure docker installed
if command -v docker &> /dev/null; then
    echo "Install Docker please"
    exit 0
fi

# Make sure docker-compose is installed
if command -v docker-compose &> /dev/null; then
    echo "Install docker-compose please"
    exit 0
fi

# Make sure .env variables are ready


# Run docker compose
docker compose up -d


