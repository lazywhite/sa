#! /bin/sh
#
# docker-clean.sh
# Copyright (C) 2017 white <white@Whites-Mac-Air.local>
#
# Distributed under terms of the MIT license.
#    
# Used under Macos X only


IMAGES=$@

echo "This will remove all your current containers and images except for:"
echo ${IMAGES}
read -p "Are you sure? [yes/NO] " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

TMP_DIR=$(mktemp -d)

pushd $TMP_DIR >/dev/null

open -a Docker
echo "=> Saving the specified images"
for image in ${IMAGES}; do
    echo "==> Saving ${image}"
    tar=$(echo -n ${image} | base64)
    docker save -o ${tar}.tar ${image}
    echo "==> Done."
done

echo "=> Cleaning up"
echo -n "==> Quiting Docker"
osascript -e 'quit app "Docker"'
while docker info >/dev/null 2>&1; do
    echo -n "."
    sleep 1
done;
echo ""

echo "==> Removing Docker.qcow2 file"
rm ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2

echo "==> Launching Docker"
open -a Docker
echo -n "==> Waiting for Docker to start"
until docker info >/dev/null 2>&1; do
    echo -n "."
    sleep 1
done;
echo ""

echo "=> Done."

echo "=> Loading saved images"
for image in ${IMAGES}; do
    echo "==> Loading ${image}"
    tar=$(echo -n ${image} | base64)
    docker load -q -i ${tar}.tar || exit 1
    echo "==> Done."
done

popd >/dev/null
rm -r ${TMP_DIR}


