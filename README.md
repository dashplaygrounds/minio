# minio

## Pre-requisites
1. Enable in DO firewall ports `9998-9999`
2. Test: `curl http://minio2023.dashmark.me:9999`

## Install server
`source deploy.sh`

## Install minio-client (mc)
```
wget https://dl.min.io/client/mc/release/linux-amd64/mc
sudo chmod +x mc
sudo mv mc /usr/local/bin/mc

mc --version && mc --help
rm -rf $HOME/.mc && ls -a ~
mc alias set local http://minio2023.dashmark.me:9998 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
# Added `local` successfully.

mc admin info local
<!-- 
●  minio2023.dashmark.me:9998
   Uptime: 31 seconds
   Version: 2023-09-30T07:02:29Z
   Network: 1/1 OK
   Drives: 1/1 OK
   Pool: 1

Pools:
   1st, Erasure sets: 1, Drives per erasure set: 1

1 drive online, 0 drives offline 
-->

mc mb
mc ls

mc admin user add $ALIAS $ACCESSKEY $SECRETKEY
mc admin policy attach $ALIAS readwrite --user=$USERNAME
```

## Minio guide
- https://min.io/docs/minio/container/
- https://github.com/minio/mc/blob/master/docs/minio-client-complete-guide.md
- https://min.io/docs/minio/linux/administration/identity-access-management/minio-user-management.html