using ParallelMaximumClique
using Test
using Graphs, SparseArrays, LinearAlgebra

PMC = ParallelMaximumClique

@testset "normalize!" begin
    # Write your tests here.
    A = [[1 ;; 0 ;; 3]; [0 ;; 1 ;; 1] ; [-1 ;; 3 ;; 9]]
    AN = [[1 ;; 0 ;; 1]; [0 ;; 1 ;; 1] ; [1 ;; 1 ;;  1]]

    AS = sparse(A)

    PMC.normalize!(AS)

    @test AS == sparse(AN) 
    

end


@testset "pmc_wrapper" begin

    ei = Int32.([1,1,2])
    ej = Int32.([2,3,3])

    output = zeros(Int32, 3)

    N = maximum_clique!(output, ej, ei; verbose=0)

    @test N == 3

    N = maximum_clique!(output, ej, ei; verbose=1)

end




@testset "max_clique(complete graph)" begin

    g = complete_graph(5)

    expected_out = [1,2,3,4,5] |> sort

    out = maximum_clique(g) |> sort

    @test out == expected_out

end




@testset "max_clique(not complete graph)" begin

    g = complete_graph(5)

    rem_edge!(g, 4,5)
    rem_edge!(g, 5,3)

    expected_out = [1,2,3,4] |> sort

    out = maximum_clique(g) |> sort

    @test out == expected_out

end

