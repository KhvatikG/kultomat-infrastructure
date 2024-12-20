#!/bin/bash
set -e

# Проверка наличия .env файла
if [ ! -f ".env" ]; then
    echo "Error: .env file not found"
    echo "Please create .env file based on example.env"
    exit 1
fi

# Создание директорий для логов
echo "Creating log directories..."
mkdir -p ../logs/orders-closer ../logs/time-controller

# Backup старых логов
timestamp=$(date +%Y%m%d_%H%M%S)
if [ -d "../logs" ]; then
    echo "Backing up logs..."
    tar -czf "../logs_backup_${timestamp}.tar.gz" ../logs
fi

# Остановка и удаление старых контейнеров
echo "Stopping existing containers..."
docker-compose down || {
    echo "Error stopping containers"
    exit 1
}

# Построение и запуск новых контейнеров
echo "Building and starting new containers..."
docker-compose up -d --build || {
    echo "Error starting containers"
    exit 1
}

# Проверка статуса контейнеров
echo "Checking container status..."
sleep 5
if [ "$(docker-compose ps -q | wc -l)" -ne "2" ]; then
    echo "Error: Not all containers are running"
    docker-compose logs
    exit 1
fi

echo "Deployment completed successfully"