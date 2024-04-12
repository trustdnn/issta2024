# Replication Pacakge for ISSTA2024

In this repository, we provide the artifacts and replication package for our ISSTA2024 submission "Evaluating the Trustworthiness of Deep Neural Networks in Deployment - A Comparative Study (Replicability Study)". We prepared a self-contained [Docker image](https://hub.docker.com/layers/trustdnn/issta2024/replication_package/images/sha256-1d532853f0e005cf77a9f82288f58350a1130044cf96c8b0d50bfc118aaa1620?context=explore) that includes the code, datasets, models, configurations, and scripts for reproducing and replicating our evaluation and results.

## Getting Started

### Requirements:
- Docker
- linux/amd64 (OS/Arch)
- 9GB of available storage


### Installation
Run the following commands to obtain the replication package (requires close to 6 GB of available storage):

```shell
$ docker push trustdnn/issta2024:replication_package
$ mkdir experiments
# This will instantiate a docker container named `replication` in your environment which will map the local folder `experiments` with the `experiments` folder in the container 
$ docker run -it -v ${PWD}/experiments:/experiments trustdnn/issta2024:replication_package /bin/bash
```

### Demo on tabular data
Run the following commands in the docker container previously instantiated:

```shell
# This will tell which configuration to pick
$ export TRUSTDNN_DIR=/.trustdnn/comparison/

# This will run Prophecy's analysis on the PD dataset and models and save the output under /workdir folder in the container
$ trustdnn execute -id 1 -b trustbench -t prophecy -d PD -wd /workdir analyze
 
# This will run Prophecy's inference on the previous artifacts outputed during analysis
$ trustdnn execute -id 1 -b trustbench -t prophecy -d BM GC HP PD CIFAR10 -wd /workdir infer

# This will compute the efficiency of Prophecy's executions (under /workdir/efficiency.csv in the container)
$ trustdnn evaluate -wd /workdir efficiency

# This will compute the effectiveness of Prophecy's notifications (saved under /workdir/effectiveness.csv in the container)
$ trustdnn evaluate -wd /workdir effectiveness -i
```


## Detailed Description

## What is inside the Docker image?

We placed an anonymized version of the benchmark, framework, and tools under `/opt` folder. 
We also made publicly avaliable their anonymized repository under the following links:
- TrustDNN (https://anonymous.4open.science/r/TrustDNN-2A1E)
- TrustBench (https://anonymous.4open.science/r/TrustBench-574C)
- Prophecy (https://anonymous.4open.science/r/Prophecy-77F5)
- DeepInfer (https://anonymous.4open.science/r/DeepInfer-FDF7)
- SelfChecker (https://anonymous.4open.science/r/SelfChecker-E7FB)

The configurations for the tools are placed under `/.trustdnn`.
The configurations for the datasets are placed under `/.trustbench`. 
The configuration for the models have been removed for anonymity reasons.

Our version of the artifacts from DeepInfer's replication package are placed under `/.deepinfer_artifacts`. For TrustDNN to operate with those artifacts, we had to create dummy files for the training datasets since DeepInfer's replication package does not provide them.


### Replicating the Experiments and Results in our Evaluation
Run the following scripts inside the Docker container previously instantiated (requires at least 3.5 GB of available storage):

```shell

# To obtain the replication results of DeepInfer and SelfChecker.
$ ./replicate.sh

# To obtain the comparison results for all approaches.
$ ./compare.sh
```

> NOTE: We ran all of our experiments on a remote server with 128 GB of RAM and a 2.1 GHz Intel(R) Xeon(R) Silver 4130 with 48 cores. The execution time on that environment was approximately of 1 hour and 40 minutes. From our experiments, the replication of Self-Checker on image data/model demanded considerable memory usage (+120 GB of RAM), which we commented in our paper in RQ4. To conduct our experiments successfully, we advise running the replication package on a machine with similar RAM capacity.


### Artifacts and Results
Upon succesfull completion, you should find under your local folder `experiments` a identical version of the content in our publicly available [artifacts and results for the replication package](https://zenodo.org/records/10963043).
Inside that folder you will find two folders, namely `replication` (RQ1) and `comparison` (RQ2, RQ3, and RQ4). For each one, you will find the files `efficiency.csv` and  `effectiveness.csv` with the efficiency and effectiveness results, respectively. In the folders with the results you will also find additional figures and all the artifacts and logs generated by the tools for each dataset/model. Additionally, the command `trustdnn evaluate -wd <workdir> effectiveness` prints the violation/satisfaction counts for DeepInfer and generates the bar plot in Figure 3.
 
