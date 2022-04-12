#!/bin/bash
#
# Build docker containers

# =================================================================
# |  Functions                                                    |
# =================================================================

if [ -z "$1" ]
then
	export COMPOSE_PROJECT_NAME="${PWD##*/}"
else
	export COMPOSE_PROJECT_NAME="$1"
fi

function cleanContainers() {
	container=$(docker ps -a | grep ''${COMPOSE_PROJECT_NAME}'-jupyterlab' | awk '{print $1}')
	echo "${comtainer}"
	docker stop "${container}"
	docker rm "${container}"
	container="$(docker ps -a | grep ''${COMPOSE_PROJECT_NAME}'-spark-worker' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep ''${COMPOSE_PROJECT_NAME}'-spark-worker' -m 1 | awk '{print $1}')"
    done

	container="$(docker ps -a | grep ''${COMPOSE_PROJECT_NAME}'-spark-master' | awk '{print $1}')"
	docker stop "${container}"
	docker rm "${container}"
}

function cleanVolume() {
	docker volume rm "${COMPOSE_PROJECT_NAME}_shared-workspace"
}

function buildContainers() {
    docker-compose -f docker-compose.yml up --build --detach
}

# =================================================================
# |  Main                                                         |
# =================================================================

cleanContainers;
cleanVolume;
buildContainers;