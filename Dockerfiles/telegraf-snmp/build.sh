#!/bin/bash

DOCKER_NAME="telegraf-snmp"
VERSION="1.20.3"

if [[ "$(docker images -q ${DOCKER_NAME}:${VERSION/\~/-} 2> /dev/null)" != "" ]]; then
while true; do
    read -p "${DOCKER_NAME}:${VERSION/\~/-} exist in docer repository - do you whant to remove it? [y/n]: " answer
    case ${answer:0:1} in
        y|Y) 
            docker rmi ${DOCKER_NAME}:${VERSION/\~/-}
            echo ""
            echo "DONE: Docker Remove Image - ${DOCKER_NAME}:${VERSION/\~/-}"
            echo ""
            break;;
        n|N) 
            echo "ERROR: You can't build new image when image with same tag exist in repository !!!"
            echo "All Done."
            exit;;
        *) echo "Please answer yes or no [y/n].";;
    esac
done
fi

echo "Docker build: ${DOCKER_NAME}:${VERSION/\~/-}"
docker build --build-arg VERSION=${VERSION} -t ${DOCKER_NAME}:${VERSION/\~/-} .
echo ""
echo "Build Completed."
docker images | grep -e ${DOCKER_NAME} -e REPOSITORY -e ${VERSION/\~/-}
echo ""

while true; do
    read -p "Do you wish to save created docker image to tar.gz file? [y/n]: " answer
    case ${answer:0:1} in
        y|Y) 
            echo ""
            echo "Save docker image to file."
            echo ""
            break;;
        n|N) 
            echo "All Done."
            exit;;
        *) echo "Please answer yes or no [y/n].";;
    esac
done

docker save ${DOCKER_NAME}:${VERSION/\~/-} | gzip > ${DOCKER_NAME}_${VERSION/\~/-}.tar.gz
ls -lah | grep ${DOCKER_NAME} | grep tar.gz
echo "All Done."