"""
    wave_eta_0(cur_rho; cur_w=nothing)

Lorem ipsum dolor sit amet.
"""
function wave_eta_0(cur_rho; cur_w=nothing)
  if cur_w == nothing
    cur_w = wave_w(cur_rho)
  end

  cur_eta_0 = 8.0

  cur_eta_0 *= cur_w ^ 2

  cur_eta_0 /= ( 5 + Z_eff )

  cur_eta_0 += wave_D()

  cur_eta_0 += ( wave_K() / cur_w )

  cur_eta_0
end
