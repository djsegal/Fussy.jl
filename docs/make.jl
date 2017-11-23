using Documenter, Fusion

makedocs(
  modules = [Fusion],
  format = :html,
  sitename = "Fusion.jl",
  pages = Any[
    "Home" => "index.md",
    "Code" => "code.md",
    "Glossary" => "glossary.md"
  ]
)

deploydocs(
  repo = "github.com/djsegal/Fusion.jl.git",
  julia  = "release",
  target = "build",
  deps = nothing,
  make = nothing
)
