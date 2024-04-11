#/bin/bash

export TRUSTDNN_DIR=/.trustdnn/replication

# Run DeepInfer's analysis on its replication artifacts
trustdnn execute -id 1 -b deepinfer_artifacts -t deepinfer -d BM GC HP PD -wd /experiments/replication analyze

# Run DeepInfer's inference on its replication artifacts
trustdnn execute -id 1 -b deepinfer_artifacts -t deepinfer -d BM GC HP PD -wd /experiments/replication infer

# Run SelfChecker's analysis on CIFAR10
trustdnn execute -id 1 -b trustbench -t selfchecker -d CIFAR10 -wd /experiments/replication analyze

# Run SelfChecker's inference on CIFAR10
trustdnn execute -id 1 -b trustbench -t selfchecker -d CIFAR10 -wd /experiments/replication infer

# Compute efficiency
trustdnn evaluate -wd /experiments/replication efficiency

# Compute effectiveness
trustdnn evaluate -wd /experiments/replication effectiveness

