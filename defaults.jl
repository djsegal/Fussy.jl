Q = 50
kappa = 1.8
delta = 0.5
epsilon = 0.25
N_G = 0.8
H = 1

nu_n = 0.3
nu_T = 1.2

eta_CD = 0.35
eta_T = 0.4
eta_RF = 0.4

Z_eff = 1.5
rho_m = 0.6
A = 2.5

wave_theta = 0

blanket_given_thickness = 0.89u"m"

max_beta_N = 0.026
max_P_W = 3 * ( 1u"MW" / 1u"m^2" )
max_h_parallel = 500 * ( 1u"MW" / 1u"m^2" )

enable_bremsstrahlung = true
enable_eta_CD_derive = true
enable_blanket_derive = true

confinement_scaling = Dict(
  "constant" => 0.145,
  "I_M" => ( 93 // 100 ),
  "R_0" => ( 139 // 100 ),
  "a" => ( 58 // 100 ),
  "kappa" => ( 78 // 100 ),
  "n_bar" => ( 41 // 100 ),
  "B_0" => ( 15 // 100 ),
  "A" => ( 19 // 100 ),
  "P" => ( 69 // 100 )
)

symbol_list = []
append!(symbol_list, ["T_k", "R_0", "B_0"])
append!(symbol_list, ["I_M", "n_bar", "tau_E"])
append!(symbol_list, ["sigma_v_hat", "K_CD_denom"])
append!(symbol_list, ["beta_N", "P_W", "h_parallel"])

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
K_CD_denom = symbol_dict["K_CD_denom"]

beta_N = symbol_dict["beta_N"]
P_W = symbol_dict["P_W"] * ( 1u"MW" / 1u"m^2" )
h_parallel = symbol_dict["h_parallel"] * ( 1u"MW" / 1u"m^2" )

Tokamak.load_input("magnet_defaults.jl", true)
Tokamak.load_input("econ_defaults.jl", true)
