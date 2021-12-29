using Documenter
using VectorDataUtils

DocMeta.setdocmeta!(VectorDataUtils, :DocTestSetup, :(using VectorDataUtils); recursive=true)
doctest(VectorDataUtils)

makedocs(
    sitename = "VectorDataUtils",
    format = Documenter.HTML(),
    modules = [VectorDataUtils],
    pages = [
        "Home" => "index.md",
        "Contents" => [
            "norms.md"
            "distances.md"
        ],
    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/vidhyasaharan/VectorDataUtils.jl.git"
)
