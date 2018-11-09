#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASENAME=$(basename "$CURRENT_DIR")

echo "Will share this folder:$BASENAME with the docker container".
echo "stop container:" && docker stop ci_xenial || true
echo "remove container:" && docker rm ci_xenial || true
echo "rerun container ci_xenial:"
cd ${CURRENT_DIR} && docker run -d -it --name ci_xenial -v $(pwd):/${BASENAME}:ro local_xenial # read only share
docker exec -it ci_xenial /bin/bash
