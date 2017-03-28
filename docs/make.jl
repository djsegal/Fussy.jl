using Documenter, Tokamak

makedocs(
  format = :html,
  sitename = "Tokamak.jl"
)

deploydocs(
  repo   = "github.com/djsegal/Tokamak.jl.git"
)
