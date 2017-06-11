@doc """
    magnet_k_array()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_k_array()
  [
    (-(1+delta)+2*magnet_l0^4*(3-2*magnet_l0^2))/(magnet_l0^2*(1-magnet_l0^2)^2),
    (2*(1+delta)-2*magnet_l0^2*(3-magnet_l0^4))/(magnet_l0^2*(1-magnet_l0^2)^2),
    (-(1+delta)+2*magnet_l0^2*(2-magnet_l0^2))/(magnet_l0^2*(1-magnet_l0^2)^2)
  ]
end
