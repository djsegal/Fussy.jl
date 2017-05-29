c1 = 14.26;
c2 = -0.05675;

a =   4.132e+04;
b =    -0.08001;
c =   -4.13e+04;
d =    -0.08002;

TargetHeatLeavingBlanket = .00004;

Pw = 4;

# fitFunc = @(x) c1 * exp(c2 * x);
f(x) = a*exp(b*x) + c*exp(d*x);

xx =  linspace(0,200,1001);
localHeatingNorm = f(xx);

localHeating = localHeatingNorm * Pw / 14.6;
local_cumHeat = cumsum(localHeating);
totalHeat = sum(localHeating);
local_HeatRemaining = sum(localHeating) - local_cumHeat;
# apple =
indofMin = indmin(abs(local_HeatRemaining - TargetHeatLeavingBlanket))
rcrit = xx[indofMin]
match = local_HeatRemaining[indofMin]

# figure;
# figure;
#plot(xx, local_HeatRemaining);
#ylim([0, 1e-2]);
# xlim([0 200])
