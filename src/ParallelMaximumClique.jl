module ParallelMaximumClique


using Graphs, SparseArrays, LinearAlgebra
using PMC_jll

include("utils.jl")
include("wrapper.jl")

export maximum_clique, maximum_clique!


end
