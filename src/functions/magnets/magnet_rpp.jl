"""
    magnet_rpp()

Lorem ipsum dolor sit amet.
"""
function magnet_rpp()

  rm = 3.3

  cur_magnet_rpp = []

  append!(cur_magnet_rpp, magnet_rd_array())

  append!(cur_magnet_rpp, magnet_rp_array())

  push!(cur_magnet_rpp, rm)

  cur_magnet_rpp

end
