FROM cluster-base

# workspace

COPY workspace/ ${SHARED_WORKSPACE}/

# JupyterLab

ARG spark_version
ARG jupyterlab_version

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install wget==3.2 pyspark==${spark_version} jupyterlab==${jupyterlab_version} pandas pyarrow plotly

# -- Runtime

EXPOSE 8888

WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=