using Tokamak
using Base.Test

@testset "All Tests" begin
  if ( endswith(pwd(), "/test") ) ; cd("..") ; end
  Julz.include_all_files("$(pwd())/test")
end

return
