# minio

## Pre-requisites
1. Enable in server firewall ports `9998-9999`
2. Install docker on debian

## Install server
`source deploy.sh`

## Test: 
`curl http://0.0.0.0:9999`

## Install minio-client (mc)
```
wget https://dl.min.io/client/mc/release/linux-amd64/mc
sudo chmod +x mc
sudo mv mc /usr/local/bin/mc

mc --version && mc --help
rm -rf $HOME/.mc && ls -a ~
ALIAS=local
mc alias set $ALIAS http://0.0.0.0:9998 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
# Added `local` successfully.

mc admin info local
<!-- 
●  0.0.0.0:9998
   Uptime: 31 seconds
   Version: 2023-09-30T07:02:29Z
   Network: 1/1 OK
   Drives: 1/1 OK
   Pool: 1

Pools:
   1st, Erasure sets: 1, Drives per erasure set: 1

1 drive online, 0 drives offline 
-->

mc ls
echo "hello minio" >> minio.txt
mc mb $ALIAS/go-bag
# Bucket created successfully `local/go-bag`.

# getonly.json
{
  "Version": "2012-10-17",
  "Statement": [
	{
	  "Action": [
		"s3:GetObject"
	  ],
	  "Effect": "Allow",
	  "Resource": [
		"arn:aws:s3:::go-bag/*"
	  ],
	  "Sid": ""
	}
  ]
}

mc admin policy create $ALIAS getonly getonly.json

mc anonymous set --recursive download local/go-bag/

mc anonymous links local/go-bag --recursive
// http://0.0.0.0:9998/go-bag/forest.jpg
// http://0.0.0.0:9998/go-bag/minio.txt

// http://192.168.1.240:9998/go-bag/forest.jpg
// http://192.168.1.240:9998/go-bag/minio.txt

// curl http://192.168.1.240:9998/go-bag/forest.jpg
// curl http://192.168.1.240:9998/go-bag/minio.txt

NEWUSER=marksilverio
NEWPW=marksilveriopw
// ACCESSKEY=
// SECRETKEY=
mc admin user add $ALIAS $NEWUSER $NEWPW
// mc admin user add $ALIAS $ACCESSKEY $SECRETKEY
<!-- Added user `myuser` successfully. -->
mc admin policy attach $ALIAS readwrite --user=$NEWUSER
<!-- 
Attached Policies: [readwrite]
To User: marksilverio
-->

mc cp minio.txt $ALIAS/go-bag/
// ...minio.txt: 12 B / 12 B ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 58 B/s 0s
mc ls $ALIAS/go-bag
// [2023-10-02 09:53:22 UTC]    12B minio.txt
ls /minio/data
// buckets
ls /minio/data/go-bag/
// minio.txt
mc cat $ALIAS/go-bag/minio.txt
// hello minio


```

## Minio client usage
Minio Client Usage
In this section, I will go through the basic steps of managing minio server using its client.

1. Start minio server and provide the desired minio access and secret key.
2. Start minio client.
3. Connect the minio client (mc) with minio server.
4. Create a new bucket.
5. Copy a file from minio client container inside a minio bucket.
6. Sync minio server objects on the local system.


## Minio guide
- https://min.io/docs/minio/container/
- https://github.com/minio/mc/blob/master/docs/minio-client-complete-guide.md
- https://min.io/docs/minio/linux/administration/identity-access-management/minio-user-management.html
- https://aliartiza75.medium.com/minio-server-management-using-minio-client-mc-70c8a7ce38
- https://github.com/minio/minio-js/issues/588
- https://stackoverflow.com/questions/73095191/minio-presignedputobject-generated-url-only-valid-for-days-how-to-make-it-publi
- https://stackoverflow.com/questions/74656068/minio-how-to-get-right-link-to-display-image-on-html
- Check Minio docker tags on quay.io: https://quay.io/repository/minio/minio?tab=tags