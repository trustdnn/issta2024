# Replication Pacakge for ISSTA2024

In this repository, we provide the artifacts and replication package for our ISSTA2024 submission "Evaluating the Trustworthiness of Deep Neural Networks in Deployment - A Comparative Study (Replicability Study)". We prepared a self-contained [Docker image](https://hub.docker.com/layers/trustdnn/issta2024/replication_package/images/sha256-1d532853f0e005cf77a9f82288f58350a1130044cf96c8b0d50bfc118aaa1620?context=explore) that includes the code, datasets, models, configurations, and scripts for reproducing and replicating our evaluation and results.

## Getting Started

### Requirements:
- Docker
- Any Linux distribution that supports Docker (the container was built for amd64 arch) 
  - Docker Desktop may allow running the container on Windows/MacOS (depending on your systems specs)
- 9GB of available storage


### Installation
Run the following commands to obtain the replication package (requires close to 6 GB of available storage):

```shell
$ docker pull trustdnn/issta2024:replication_package
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
We also made publicly available their repository under the following links:
- TrustDNN (https://github.com/epicosy/TrustDNN)
- TrustBench (https://github.com/epicosy/TrustBench)
- Prophecy (https://github.com/epicosy/ProphecyPlus)
- DeepInfer (https://github.com/epicosy/DeepInferPlus)
- SelfChecker (https://github.com/epicosy/SelfCheckerPlus)

Please consider those links for more information on their usage.

The configurations for the tools are placed under `/.trustdnn`.
The configurations for the datasets are placed under `/.trustbench`. 
You can also find those in this repository under `setup` directory.

The configuration for the models are not included in the Docker Image but can be found at https://github.com/epicosy/TrustBench/tree/main/config/models
The models are placed under `/.trustbench/models/` and are publicly available at:
- Bank Customers (https://www.kaggle.com/models/eduardpinconschi/bm)
- CIFAR10 (https://www.kaggle.com/models/eduardpinconschi/cifar10)
- German Credit (https://www.kaggle.com/models/eduardpinconschi/gc)
- House Price (https://www.kaggle.com/models/eduardpinconschi/hp)
- PIMA Diabetes (https://www.kaggle.com/models/eduardpinconschi/pd)

Our version of the artifacts from DeepInfer's replication package are placed under `/.deepinfer_artifacts`. For TrustDNN to operate with those artifacts, we had to create dummy files for the training datasets since DeepInfer's replication package does not provide them.


### Replicating the Experiments and Results in our Evaluation
There are two scripts under the `scripts` folder and are straightforward to use; 
The `replication.sh` script runs 60 executions while the `comparison.sh` script runs 180 executions. 
The TrustDNN framework orchestrates/automates the executions of experiments. 
Run the following scripts inside the Docker container previously instantiated (requires at least 3.5 GB of available storage):

```shell

# To obtain the replication results of DeepInfer and SelfChecker (it runs the tools on their original artifacts and computes the efficiency/effectiveness). 
$ ./replicate.sh

# To obtain the comparison results for all approaches (it runs the tools on all datasets/models and computes the efficiency/effectiveness).
$ ./compare.sh
```

> NOTE: We ran all of our experiments on a remote server with 128 GB of RAM and a 2.1 GHz Intel(R) Xeon(R) Silver 4130 with 48 cores. The execution time on that environment was approximately of 1 hour and 40 minutes. From our experiments, the replication of Self-Checker on image data/model demanded considerable memory usage (+120 GB of RAM), which we commented in our paper in RQ4. To conduct our experiments successfully, we advise running the replication package on a machine with similar RAM capacity.


### Artifacts and Results
Upon successful completion, you should find under your local folder `experiments` an identical version of the content in our publicly available artifacts and results for the replication package (the results.tar.gz file).
Inside that folder you will find two folders, namely `replication` (RQ1 and RQ2) and `comparison` (RQ3, and RQ4). For each one, you will find the files `efficiency.csv` and  `effectiveness.csv` with the efficiency and effectiveness results, respectively. In the folders with the results you will also find additional figures and all the artifacts and logs generated by the tools for each dataset/model. Additionally, the command `trustdnn evaluate -wd <workdir> effectiveness` prints the violation/satisfaction counts for DeepInfer and generates the bar plot in Figure 3.
 
