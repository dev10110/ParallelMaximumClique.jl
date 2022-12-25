using ParallelMaximumClique
using Documenter

DocMeta.setdocmeta!(ParallelMaximumClique, :DocTestSetup, :(using ParallelMaximumClique); recursive=true)

makedocs(;
    modules=[ParallelMaximumClique],
    authors="Devansh Ramgopal Agrawal <devansh@umich.edu> and contributors",
    repo="https://github.com/dev10110/ParallelMaximumClique.jl/blob/{commit}{path}#{line}",
    sitename="ParallelMaximumClique.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://dev10110.github.io/ParallelMaximumClique.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Reference" => "reference.md"
    ],
)

deploydocs(;
    repo="github.com/dev10110/ParallelMaximumClique.jl",
    devbranch="main",
)
