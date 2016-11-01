docker build 
    -f <file name>: name of the Dockerfile, default is './Dockerfile'
    --label value: metadata for an image
    --no-cache: do not use cache when building the image
    -t, --tag <value>: "value" is in 'image:tag" format


docker build -t 'test:v0.1' .
