@testset "Main Function Tests" begin

  @test isdefined(Tokamak, :main) == true

  # originalSTDOUT = STDOUT

  # (outRead, outWrite) = redirect_stdout()

  # Tokamak.main()

  # close(outWrite)

  # data = readavailable(outRead)

  # close(outRead)

  # redirect_stdout(originalSTDOUT)

  # @test String(data) == "done.\n"

end
