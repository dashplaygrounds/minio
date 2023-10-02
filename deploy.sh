docker network create minio_net
sudo mkdir -p /minio/data
sudo chown -R $USER:$USER /minio/data
set -o allexport; source ./utils/.env; set +o allexport
docker compose up -d
watch docker ps -a