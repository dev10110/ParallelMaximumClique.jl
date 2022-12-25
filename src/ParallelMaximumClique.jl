module ParallelMaximumClique


using Graphs, SparseArrays, LinearAlgebra
using LibPMC_jll

"""
    normalize!(A::SparseMatrixCSC)

replaces each non-zero element of A with a 1.
"""
function normalize!(A::SparseMatrixCSC{Tv, Ti}) where {Tv, Ti}

  for i in eachindex(A.nzval)
    A.nzval[i] = one(Tv)
  end

end

"""
    normalize!(A<:AbstractMatrix)

replaces each non-zero element of A with a 1.
"""
function normalize!(A::AbstractMatrix{T}) where {T}

  for i in eachindex(A)
    if A[i] != zero(T)
      A[i] = one(T)
    end
  end

end


AG = Graphs.AbstractGraph

function maximum_clique(g::G) where {T, G<:AbstractGraph{T}}

  @assert is_directed(g) == false "PMC only supports undirected graphs"

  A = adjacency_matrix(g)

  return maximum_clique(A; normalize=false)

end

function maximum_clique(A::SparseMatrixCSC; normalize=true)
  
  if normalize
    normalize!(A)
  end

  maxd = Int(maximum(sum(A, dims=1))) + 1

  ei, ej = findnz(tril(A))

  ei = map(Int32, ei)
  ej = map(Int32, ej)

  output = zeros(Int32, maxd)

  clique_size = pmc_wrapper!(output, ei, ej; verbose=0)

  res = output[1:clique_size]

  return res

end

function pmc_wrapper!(output::Vector{Int32}, ei::Vector{Int32}, ej::Vector{Int32};
  verbose=1,
  algorithm=0,
  time_limit_secs=60*60,
  remove_time_secs = 4.0,
  )

  offset=Int32(1)

  nedges = Int64(length(ei))
  outsize = Int32(length(output))

  clique_size = ccall(
              (:max_clique, libpmc),
              Cint, 
              (Clonglong, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Cint, Cint, Cint, Cdouble, Cdouble),
              nedges,
              ei,
              ej,
              outsize,
              output,
              Int32(verbose),
              Int32(algorithm),
              Int32(offset),
              Float64(time_limit_secs),
              Float64(remove_time_secs)
             )
             
   return clique_size
end

end
