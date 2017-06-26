using Tokamak
using Base.Test
using TestSetExtensions

using Unitful
using Unitful.DefaultSymbols
using SymPy

@testset ExtendedTestSet "All Tests" begin
  if ( endswith(pwd(), "/test") ) ; Base.cd("..") ; end

  seed_int = abs(rand(Int16))
  srand(seed_int)
  println("\n Seed: $seed_int \n")

  test_dir = "$(pwd())/test"

  is_focused = Julz.check_for_focus(test_dir)

  is_sorted = Julz.tests_are_sorted

  Julz.include_all_files( test_dir,
    is_testing=true, is_focused=is_focused, is_sorted=is_sorted,
    reload_function=Tokamak.load_input
  )
end

return
