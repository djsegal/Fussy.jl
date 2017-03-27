module Tokamak

  using Julz
  using JLD

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  include("../config/bootload.jl")

  function main()
    println("done.")
  end

end
