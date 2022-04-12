#!/bin/bash
#
# Build docker images

function specifyVersion() {
	SPARK_VERSION="$(grep -m 1 spark images.yml | grep -o -P '(?<=").*(?=")')"
	JUPYTERLAB_VERSION="$(grep -m 1 jupyterlab images.yml | grep -o -P '(?<=").*(?=")')"

	SPARK_VERSION_MAJOR=${SPARK_VERSION:0:1}

	if [[ "${SPARK_VERSION_MAJOR}" == "2" ]]
	then
		HADOOP_VERSION="2.70"
	elif [[ "${SPARK_VERSION_MAJOR}" == "3" ]]
	then
		HADOOP_VERSION="3.2"
	else exit 1
	fi
}

# =================================================================
# |  Functions                                                    |
# =================================================================

function cleanImages() {
	# Delete jupyter image
	docker rmi -f "$(docker images | grep -m 1 'jupyterlab' | awk '{print $3}')"

	# Delete spark images
	docker rmi -f "$(docker images | grep -m 1 'spark-worker' | awk '{print $3}')"
	docker rmi -f "$(docker images | grep -m 1 'spark-master' | awk '{print $3}')"
	docker rmi -f "$(docker images | grep -m 1 'spark-base' | awk '{print $3}')"

	# Delete cluster-base image
	docker rmi -f "$(docker images | grep -m 1 'cluster-base' | awk '{print $3}')"
}

function buildImages() {
	# Build cluster-base image
	docker build \
		-f docker/cluster-base/Dockerfile \
		-t cluster-base:latest .

	# Build spark images
	docker build \
		--build-arg spark_version="${SPARK_VERSION}" \
		--build-arg hadoop_version="${HADOOP_VERSION}" \
		-f docker/spark-base/Dockerfile \
		-t spark-base:${SPARK_VERSION} .

	docker build \
		--build-arg spark_version=${SPARK_VERSION} \
		-f docker/spark-master/Dockerfile \
		-t spark-master:${SPARK_VERSION} .

	docker build \
		--build-arg spark_version=${SPARK_VERSION} \
		-f docker/spark-worker/Dockerfile \
		-t spark-worker:${SPARK_VERSION} .

	# Build jupyterlab image
	docker build \
		--build-arg spark_version="${SPARK_VERSION}" \
		--build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
		-f docker/jupyterlab/Dockerfile \
		-t jupyterlab:${JUPYTERLAB_VERSION}-spark-${SPARK_VERSION} .
}

# =================================================================
# |  Main                                                         |
# =================================================================

specifyVersion;
cleanImages;
buildImages;