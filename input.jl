epsilon = 0.25
kappa = 1.8
beta_N = 0.026
N_G = 0.8
H = 1
Q = 50
nu_n = 0.3
nu_T = 1.2
Z_eff = 1.5
eta_CD = 0.35
eta_T = 0.4
eta_RF = 0.4
P_W = 2.5
q_K = 2

symbol_list = []
append!(symbol_list, ["T_k", "R_0", "B_0"])
append!(symbol_list, ["I_M", "n_bar", "tau_E"])
append!(symbol_list, ["sigma_v_hat"])

symbol_dict = Dict()
for cur_symbol in symbol_list
  symbol_dict[cur_symbol] = symbols(cur_symbol, positive=true)
end

T_k = symbol_dict["T_k"] * 1u"keV"
R_0 = symbol_dict["R_0"] * 1u"m"
B_0 = symbol_dict["B_0"] * 1u"T"

n_bar = symbol_dict["n_bar"] * 1u"n20"
I_M = symbol_dict["I_M"] * 1u"MA"
tau_E = symbol_dict["tau_E"] * 1u"s"

sigma_v_hat = symbol_dict["sigma_v_hat"] * 1u"m^3/s"

rho_m = 0.6
M = 2.5
