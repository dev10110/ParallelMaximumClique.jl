
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
