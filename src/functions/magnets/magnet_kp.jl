"""
    magnet_kp()

Lorem ipsum dolor sit amet.
"""
function magnet_kp()
  (4*magnet_rhop()./((1 + magnet_rhop()).^2 + magnet_etap().^2))
end
