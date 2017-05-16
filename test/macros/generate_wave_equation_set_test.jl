@testset "Generate Wave Equation Set Macro Tests" begin

  @test isdefined(Tokamak, Symbol("@generate_wave_equation_set")) == true

end
