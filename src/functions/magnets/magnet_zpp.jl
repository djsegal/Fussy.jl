"""
    magnet_zpp()

Lorem ipsum dolor sit amet.
"""
function magnet_zpp()

  zm = 0

  cur_magnet_zpp = []

  append!(cur_magnet_zpp, magnet_zd_array())

  append!(cur_magnet_zpp, magnet_zp_array())

  push!(cur_magnet_zpp, zm)

  cur_magnet_zpp

end
