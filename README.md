# LatentChannelNetwork.jl
Julia implementation of the EM algorithm for [Latent Channel Network Models](https://arxiv.org/abs/1906.04563).

## Introduction

The Latent Channel Network (LCN) is a model for undirected graphs in which nodes share an observed edge if they make a connection through at least one latent channel. This is meant to reflect modern social dynamics; we are likely to make social connections if we communicate through some group, whether it be due to work, hobbies, familial ties, etc., but it is not necessary to share all social groups.

We can describe this model mathematically by giving each node in the graph a vector of probabilities of length K. The probability of two nodes making a connection through the k'th channel is the product of the k'th element of their probability vectors. For here, the probability two nodes share an edge is one minus the probability they make no connections through any of the K channels.

## Installation 
To install the Julia package:
```
Pkg.add("https://github.com/pistacliffcho/LatentChannelNetwork.jl")
```

## Basic Usage
Building latent channel network object:
```
lcn_model = makeLCN(edgeList, K)
```
with `edgeList` a nx2 `Matrix{Int64}` of undirected edge pairs and `K` is the number of channels. 

Fitting model:
```
# Parallel implementation
em_parallel!(lcn_model, iters = 10000)
# Serial implementation
em_serial!(lcn_model, iters = 10000)
```

Extracting channel probabilities:
```
chan_probs = lcn_model.pmat
```

Plotting channel probabilities by categorical data:
```
heatMap(lcn_model, label)
```
Plots a heat map of channel probabilities, sorted by category given by vector `label`. 
