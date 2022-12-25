# ParallelMaximumClique

# [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://dev10110.github.io/ParallelMaximumClique.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://dev10110.github.io/ParallelMaximumClique.jl/dev/)
[![Build Status](https://github.com/dev10110/ParallelMaximumClique.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/dev10110/ParallelMaximumClique.jl/actions/workflows/CI.yml?query=branch%3Amain)


This package wraps [`dev10110/pmc`](https://github.com/dev10110/pmc) (that is a fork of [`ryanrossi/pmc`](https://github.com/ryanrossi/pmc)) as a Julia library.

## Installation

Simply 
```
] add https://github.com/dev10110/ParallelMaximumClique.jl
```

## Usage

Minimal Example, using `Graphs.jl` interface
```
using Graphs, ParallelMaximumClique

# construct a graph
g = barabasi_albert(100, 25)

# determine the nodes in the maximum clique
clique = maximum_clique(g)
```

Alternatively, provide a sparse adjacency matrix:
```
using ParallelMaximumClique, SparseArrays

# construct the adjacency matrix
A = adjacency_matrix(...)

clique = maximum_clique(sparse(A))
```

There is a more low-level interfance described in the reference page. Optional arguments are also described there. 


## Licence/Citation
All credit for this package goes to the original authors. I, Dev, have simply wrapped it into a Julia library.  As per the original terms and conditions:

```
Terms and conditions
Please feel free to use these codes. We only ask that you cite:

Ryan A. Rossi, David F. Gleich, Assefaw H. Gebremedhin, Md. Mostofa Patwary,  
A Fast Parallel Maximum Clique Algorithm for Large Sparse Graphs and Temporal  
Strong Components, arXiv preprint 1302.6256, 2013.  
These codes are research prototypes and may not work for you. No promises. But do email if you run into problems.

Copyright 2011-2013, Ryan A. Rossi. All rights reserved.
```

## Gotchas

1. In the process of making this a Julia library, I've had to make it single-threaded, to avoid the use of `OpenMP`. That said, the library is stil incredibly quick. 

2. This library has not been extensively tested. In the words of Rossi: `These codes are research prototypes and may not work for you. No promises. But do email if you run into problems.`

3. There is much more functionality in [the original repo](https://github.com/ryanrossi/pmc). If you want more functionality exposed, email me at `devansh@umich.edu`, and I'll modify [my fork](https://github.com/dev10110/pmc) to expose more of the functions. 
