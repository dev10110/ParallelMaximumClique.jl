
"""
    maximum_clique(g::G; kwargs...) where {T, G<:AbstractGraph{T}}

returns a Vector{Int32} of the nodes of g that are in the maximum clique in g

all `kwargs` are passed to `maximum_clique!`
"""
function maximum_clique(g::G; kwargs...) where {T, G<:AbstractGraph{T}}

  @assert is_directed(g) == false "PMC only supports undirected graphs"

  A = adjacency_matrix(g)

  return maximum_clique(A; normalize=false, kwargs...)

end


"""
    maximum_clique(A::SparseMatrixCSC; normalize=true, kwargs...)


returns a Vector{Int32} of the nodes in the maximum clique of g, where A is the adjacency matrix of g. 

all `kwargs` are passed to `maximum_clique!`
"""
function maximum_clique(A::SparseMatrixCSC; normalize=true, kwargs...)
  
  if normalize
    normalize!(A)
  end

  maxd = Int(maximum(sum(A, dims=1))) + 1

  ei, ej = findnz(tril(A))

  ei = map(Int32, ei)
  ej = map(Int32, ej)

  output = zeros(Int32, maxd)

  clique_size = maximum_clique!(output, ei, ej; kwargs...)

  res = output[1:clique_size]

  return res

end

"""
    int K = maximum_clique!(ouput::Vector{Int32}, ei::Vector{Int32}, ej::Vector{Int32}; 
        verbose=0; 
        algorithm=0; 
        time_limit_secs=3600.0;
        remove_time_secs=4.0)

Inputs:
 - `ei`: the vector of edge sources
 - `ej`: the vector of edge destinations

Outputs:
 - `K`: the maximum clique size
 - `output`: the vector containing a list of nodes in the maximum clique (modified in-place)

Parameters:
 - `verbose`: set to positive integer to print additional debug statements
 - `algorithm`: choose between {0,1,2}
 - `time_limit_secs`: maximum compute time
 - `remove_time_secs`: maximum time before the graph gets reduced.

Notes:
 - for an edge to be valid, `ei[k] > ej[k]` for all `k`.
 - only the first `K` elements of `output` are modified.

"""
function maximum_clique!(output::Vector{Int32}, ei::Vector{Int32}, ej::Vector{Int32};
  verbose=0,
  algorithm=0,
  time_limit_secs=60*60.0,
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
