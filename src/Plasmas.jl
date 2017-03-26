module Plasmas

  import Julz

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  include("../config/bootload.jl")

  function main()
    println("done.")
  end

end
