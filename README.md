# minio

## Install minio-client (mc)
```
wget https://dl.min.io/client/mc/release/linux-amd64/mc
sudo chmod +x mc
sudo mv mc /usr/local/bin/mc

mc --version && mc --help
mc alias set local http://minio2023.dashmark.me:9999 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD

mc admin info local
```