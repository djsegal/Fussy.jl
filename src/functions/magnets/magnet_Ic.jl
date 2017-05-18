"""
    magnet_Ic()

Lorem ipsum dolor sit amet.
"""
function magnet_Ic()
  ITF = 2*pi*( B_0 / 1u"T" )*( R_0 / 1u"m" )/standard_mu_0 # Total Current for given ( B_0 / 1u"T" )
  Ic = ITF/magnet_num_coils # Current per coil
end
