FROM python:3.10

RUN apt update && apt -y upgrade

ENV TRUSTBENCH_PATH=/.trustbench
ENV KAGGLE_CONFIG_DIR=/.kaggle

# Install 
WORKDIR /opt/TrustBench
COPY repos/TrustBench /opt/TrustBench
RUN pip install .

WORKDIR /opt/TrustDNN
COPY repos/TrustDNN /opt/TrustDNN
RUN pip install .

WORKDIR /opt/ProphecyPlus
COPY repos/ProphecyPlus /opt/ProphecyPlus
RUN pip install -r requirements.txt

WORKDIR /opt/DeepInferPlus
COPY repos/DeepInferPlus /opt/DeepInferPlus
RUN pip install -r requirements.txt

WORKDIR /opt/SelfCheckerPlus
COPY repos/SelfCheckerPlus /opt/SelfCheckerPlus
RUN pip install -r requirements.txt

# Setup

COPY setup/.deepinfer_artifacts /.deepinfer_artifacts
COPY setup/.trustbench /.trustbench
COPY setup/.trustdnn /.trustdnn
COPY setup/.kaggle /.kaggle

WORKDIR /

# Prepare data and models

RUN trustbench collect -s kaggle -d -m && trustbench collect -s keras -d
RUN trustbench prepare
RUN trustbench detail -d PD && trustbench detail -d HP &&\
    trustbench detail -d GC && trustbench detail -d BM &&\
    trustbench detail -d CIFAR10

# Remove keys
RUN rm -r .kaggle
RUN rm -r .trustbench/config/models

COPY scripts/ /
