mkdir -p /miniodata
export MINIO_ROOT_USER=admin 
export MINIO_ROOT_PASSWORD=password 
nohup minio server --address ":9000" /miniodata  2>&1 &
