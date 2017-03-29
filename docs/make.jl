using Documenter, Tokamak

makedocs(
  modules = [Tokamak],
  format = :html,
  sitename = "Tokamak.jl",
  pages = Any[
    "Home" => "index.md",
  ]
)

deploydocs(
  repo = "github.com/djsegal/Tokamak.jl.git",
  target = "build",
  deps = nothing,
  make = nothing
)
