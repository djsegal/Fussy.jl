"""
    magnet_rpp()

Lorem ipsum dolor sit amet.
"""
function magnet_rpp()
  r1, r6, r2, r5, r3, r4 = magnet_rd_array()
  rp2, rp5, rp3, rp4 = magnet_rp_array()

  rm = 3.3

  cur_magnet_rpp = [r1 r2 r3 r4 r5 r6 rp2 rp5 rp3 rp4 rm]

  cur_magnet_rpp
end
