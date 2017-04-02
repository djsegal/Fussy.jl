using Documenter, Tokamak

makedocs(
  modules = [Tokamak],
  format = :html,
  sitename = "Tokamak.jl",
  pages = Any[
    "Home" => "index.md",
    "Code" => "code.md",
    "Glossary" => "glossary.md"
  ]
)

deploydocs(
  repo = "github.com/djsegal/Tokamak.jl.git",
  target = "build",
  deps = nothing,
  make = nothing
)
