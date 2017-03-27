using Documenter, Tokamak

makedocs(
  format = :html,
  modules = [ Tokamak ],
  sitename = "Tokamak",
  pages = [
  ]
)

deploydocs(
  repo   = "github.com/djsegal/Tokamak.jl.git",
  target = "build",
  deps   = nothing,
  make   = nothing
)
