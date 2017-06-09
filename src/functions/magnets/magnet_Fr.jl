"""
    magnet_Fr(ri,rj,zi,zj,Ii,Ij)

Forces on PF and Divertor Coils (Radial Force).
"""
function magnet_Fr(ri,rj,zi,zj,Ii,Ij)
  (
    standard_mu_0*Ii*Ij/2*((ri+rj)/(sqrt((ri+rj)^2+(zi-zj)^2))) *
    (elliptick(sqrt(4*ri*rj/((ri+rj)^2+(zi-zj)^2)))*ri/(ri+rj) +
    elliptice(sqrt(4*ri*rj/((ri+rj)^2+(zi-zj)^2)))*1/(1-4*ri*rj/((ri+rj)^2+(zi-zj)^2))) *
    ((4*ri*rj/((ri+rj)^2+(zi-zj)^2))/2 - ri/(ri+rj))
  )
end
