@testset "Main Function Tests" begin

  @test isdefined(Tokamak, :main) == true

  err_data = "nil"
  out_data = "nil"
  did_break = false

  originalSTDERR = STDERR
  originalSTDOUT = STDOUT

  (errRead, errWrite) = redirect_stderr()
  (outRead, outWrite) = redirect_stdout()

  Tokamak.main()

  close(outWrite)

  data = readavailable(outRead)

  close(outRead)

  close(errWrite)
  close(outWrite)

  err_data = readavailable(errRead)
  out_data = readavailable(outRead)

  close(errRead)
  close(outRead)

  redirect_stderr(originalSTDERR)
  redirect_stdout(originalSTDOUT)

  @test contains(String(data), "done.\n")

end
