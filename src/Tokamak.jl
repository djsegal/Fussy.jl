module Tokamak

  using Julz
  using QuadGK
  using SymPy

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  include("../config/bootload.jl")

  function main()
    println("done.")
  end

end
