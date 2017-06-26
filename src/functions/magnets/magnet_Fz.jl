@doc """
    magnet_Fz(ri,rj,zi,zj,Ii,Ij)

Forces on PF and Divertor Coils (Axial Force).
"""
@memoize function magnet_Fz(ri,rj,zi,zj,Ii,Ij)
  (
    standard_mu_0*Ii*Ij/2*((zi-zj)/(sqrt((ri+rj)^2+(zi-zj)^2))) *
    (elliptick(sqrt(4*ri*rj/((ri+rj)^2+(zi-zj)^2))) -
    elliptice(sqrt(4*ri*rj/((ri+rj)^2+(zi-zj)^2))) *
    (1+(1/2)*(4*ri*rj/((ri+rj)^2+(zi-zj)^2))/(1-4*ri*rj/((ri+rj)^2+(zi-zj)^2))))
  )
end