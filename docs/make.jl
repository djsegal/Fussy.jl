using Documenter, Plasmas

makedocs(
  format = :html,
  modules = [ Plasmas ],
  sitename = "Plasmas",
  pages = [
  ]
)

deploydocs(
  repo   = "github.com/djsegal/Plasmas.jl.git",
  target = "build",
  deps   = nothing,
  make   = nothing
)
