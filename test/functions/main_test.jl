# skip: true

@testset "Main Function Tests" begin

  @test isdefined(Tokamak, :main) == true

  out_data = "nil"
  did_break = false

  originalSTDOUT = STDOUT

  (outRead, outWrite) = redirect_stdout()

  Tokamak.main()

  close(outWrite)

  out_data = readavailable(outRead)

  close(outRead)

  redirect_stdout(originalSTDOUT)

  @test contains(String(out_data), "done.\n")

end
