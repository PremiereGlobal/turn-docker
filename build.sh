#!/bin/bash

docker build -t turn-docker:latest .

VER_TMP=$(docker run --rm --entrypoint="" -it turn-docker:latest /usr/bin/turnserver --version | grep "Version Coturn-" | awk '{print $2}' | awk -F "-" '{print $2}' 2> /dev/null)
echo "--------------==="
echo $VER_TMP
echo "--------------==="

GIT_HASH=$(git rev-parse HEAD)
GIT_COMMIT=${GIT_HASH::7}
VER_A=(${VER_TMP//./ })
VER_A=(${VER_A[@]})
VER_MM="${VER_A[0]}.${VER_A[1]}"

docker tag turn-docker:latest readytalk/turn-docker:${VER_TMP}
docker tag turn-docker:latest readytalk/turn-docker:${VER_MM}
docker tag turn-docker:latest readytalk/turn-docker:latest
echo "-----------------------"
echo "Saved Tag \"turn-docker:${VER_TMP}\""
echo "Saved Tag \"turn-docker:${VER_MM}\""
echo "Saved Tag \"turn-docker:latest\""
echo "-----------------------"

if [[ ${TRAVIS} && "${TRAVIS_BRANCH}" == "master" && -n $DOCKER_USERNAME && -n $DOCKER_PASSWORD ]]; then
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  docker push readytalk/turn-docker:${VER_TMP}
  docker push readytalk/turn-docker:${VER_MM}
  docker push readytalk/turn-docker:latest
fi

