#!/bin/bash

echo -e "Set Up database\n"
env_file="../.env"
export DOCKER_HOST=unix:///var/run/docker.sock

# Function to update .env
update_env() {
    local key=$1
    local value=$2
    if grep -q "^$key=" "$env_file"; then
        sed -i "s/^$key=.*/$key=$value/" "$env_file"
    else
        echo "$key=$value" >> "$env_file"
    fi
}

# Ask for the database credentials
echo "Create the db user:"
read db_user

echo "Create the db name:"
read db_name

echo "Create the db password:"
read -s db_password

echo "debug (true|false):"
read debug

# Create volume if it doesn't exist
if ! docker volume ls | grep -q data_volume; then
    docker volume create data_volume
fi

# Create network if it doesn't exist
if ! docker network ls | grep -q custom-isolated-network; then
    docker network create custom-isolated-network
fi

# Check if the .env file exists in the parent directory
if [ ! -e "$env_file" ]; then
    echo ".env file does not exist, creating it."
    cat <<EOF > "$env_file"
# Database configuration
DEBUG=$debug
SECRET_KEY=hola
DB_NAME=$db_name
DB_USER=$db_user
DB_PASS=$db_password
EOF
fi

# Assign variables
update_env "DEBUG" "$debug"
update_env "SECRET_KEY" "hola"
update_env "DB_NAME" "$db_name"
update_env "DB_USER" "$db_user"
update_env "DB_PASS" "$db_password"

echo "Run development database container? (y/n)"
read create_db
if [ "$create_db" == "y" ]; then
    if docker container ls -a | grep -q some-postgres; then
        docker container rm -f some-postgres
    fi
    docker run -d --name some-postgres -p 8000:5432 -e POSTGRES_PASSWORD="$db_password" -v data_volume:/var/lib/postgresql/data postgres
    container_id=$(docker ps -aqf "name=some-postgres")
    container_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$container_id")
    container_port=$(docker inspect -f '{{ (index (index .HostConfig.PortBindings "5432/tcp") 0).HostPort }}' "$container_id")
    echo "Container 'some-postgres' is running."
    echo "Container IP Address: $container_ip"
    echo "Container Port: $container_port"
else
    docker container start some-postgres
    container_id=$(docker ps -aqf "name=some-postgres")
    container_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$container_id")
    container_port=$(docker inspect -f '{{ (index (index .HostConfig.PortBindings "5432/tcp") 0).HostPort }}' "$container_id")
    echo "Container 'some-postgres' has been started."
    echo "Container IP Address: $container_ip"
    echo "Container Port: $container_port"
fi

docker container ls
