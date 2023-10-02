docker network create minio_net
sudo mkdir -p /minio/data
sudo chown -R $USER:$USER /minio/data
docker compose up -d