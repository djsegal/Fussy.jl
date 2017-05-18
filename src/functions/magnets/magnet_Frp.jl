"""
    magnet_Frp()

Force due to plasma.
"""
function magnet_Frp(ri,rm,zi,zm,Ii,Im)
  (
    standard_mu_0*Ii*Im/2*((ri+rm)/(sqrt((ri+rm)^2+(zi-zm)^2))) *
    (Elliptic.K(sqrt(4*ri*rm/((ri+rm)^2+(zi-zm)^2)))*ri/(ri+rm) +
    Elliptic.E(sqrt(4*ri*rm/((ri+rm)^2+(zi-zm)^2)))*1/(1-4*ri*rm/((ri+rm)^2+(zi-zm)^2))) *
    ((4*ri*rm/((ri+rm)^2+(zi-zm)^2))/2 - ri/(ri+rm))
  )
end
