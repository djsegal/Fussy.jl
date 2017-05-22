"""
    B0pnew()

Lorem ipsum dolor sit amet.
"""
function B0pnew()

  cur_B0pnew = standard_mu_0

  cur_B0pnew /= 2

  cur_B0pnew *= ItPF()[7:10]'

  cur_B0pnew ./= magnet_rp_array()

  cur_B0pnew

end
