# Define base image for flask application
FROM python:3.9-slim

# Set enviroment variables (non-sensitive variables)
ENV RANDOM_VARIABLE=10

# Define working direcory
WORKDIR /app

# Install requeriments
COPY requeriments.txt .
RUN pip install -r requeriments.txt

COPY . .

# Run program
CMD ["python3", "manage.py", "run", "-p", "8080"]