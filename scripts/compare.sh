#/bin/bash

export TRUSTDNN_DIR=/.trustdnn/comparison

# Run Prophecy's analysis on tabular and image data
trustdnn execute -id 1 -b trustbench -t prophecy -d BM GC HP PD CIFAR10 -wd /experiments/comparison analyze

# Run Prophecy's inference on tabular and image data
trustdnn execute -id 1 -b trustbench -t prophecy -d BM GC HP PD CIFAR10 -wd /experiments/comparison infer


# Run DeepInfer's analysis on tabular and image data
trustdnn execute -id 1 -b trustbench -t deepinfer -d BM GC HP PD CIFAR10 -wd /experiments/comparison analyze

# Run DeepInfer's inference on tabular and image data
trustdnn execute -id 1 -b trustbench -t deepinfer -d BM GC HP PD CIFAR10 -wd /experiments/comparison infer


# Run SelfChecker's analysis on tabular and image data
trustdnn execute -id 1 -b trustbench -t selfchecker -d BM GC HP PD CIFAR10 -wd /experiments/comparison analyze

# Run SelfChecker's inference on tabular and image data
trustdnn execute -id 1 -b trustbench -t selfchecker -d BM GC HP PD CIFAR10 -wd /experiments/comparison infer

# Compute efficiency
trustdnn evaluate -wd /experiments/comparison efficiency

# Compute effectiveness
trustdnn evaluate -wd /experiments/comparison effectiveness -i
