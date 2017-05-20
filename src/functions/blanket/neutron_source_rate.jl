"""
    neutron_source_rate(P_W)

Lorem ipsum dolor sit amet.
"""
function neutron_source_rate(P_W)

  cur_neutron_source_rate = P_W

  cur_neutron_source_rate /= ( Unitful.q / 1u"C" )

  cur_neutron_source_rate *= surface_area()

  cur_neutron_source_rate /= 14.1e6

  cur_neutron_source_rate

end
