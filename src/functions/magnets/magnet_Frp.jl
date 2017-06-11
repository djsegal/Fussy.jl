@doc """
    magnet_Frp(ri,rm,zi,zm,Ii,Im)

Force due to plasma.
"""
@memoize function magnet_Frp(ri,rm,zi,zm,Ii,Im)
  (
    standard_mu_0*Ii*Im/2*((ri+rm)/(sqrt((ri+rm)^2+(zi-zm)^2))) *
    (elliptick(sqrt(4*ri*rm/((ri+rm)^2+(zi-zm)^2)))*ri/(ri+rm) +
    elliptice(sqrt(4*ri*rm/((ri+rm)^2+(zi-zm)^2)))*1/(1-4*ri*rm/((ri+rm)^2+(zi-zm)^2))) *
    ((4*ri*rm/((ri+rm)^2+(zi-zm)^2))/2 - ri/(ri+rm))
  )
end
