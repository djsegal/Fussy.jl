module Tokamak

  using Julz
  using QuadGK
  using SymPy
  using DataStructures

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  if ( endswith(pwd(), "/lib/notebooks") ) ; cd("../..") ; end

  include("../config/bootload.jl")

  function main(num_points=10)
    load_input("input.jl", true)

    T_list = linspace(10, 15, num_points)

    sweep_T_k(T_list)

    println("done.")
  end

end
