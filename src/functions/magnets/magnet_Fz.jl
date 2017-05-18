"""
    magnet_Fz()

Forces on PF and Divertor Coils (Axial Force).
"""
function magnet_Fz(ri,rj,zi,zj,Ii,Ij)
  (
    standard_mu_0*Ii*Ij/2*((zi-zj)/(sqrt((ri+rj)^2+(zi-zj)^2))) *
    (Elliptic.K(sqrt(4*ri*rj/((ri+rj)^2+(zi-zj)^2))) -
    Elliptic.E(sqrt(4*ri*rj/((ri+rj)^2+(zi-zj)^2))) *
    (1+(1/2)*(4*ri*rj/((ri+rj)^2+(zi-zj)^2))/(1-4*ri*rj/((ri+rj)^2+(zi-zj)^2))))
  )
end
