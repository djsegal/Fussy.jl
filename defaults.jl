Q = 40
kappa = 1.8
delta = 0.4
epsilon = 0.25
N_G = 0.8
H = 1.0

nu_n = 0.3
nu_T = 1.2

eta_T = 0.4
eta_RF = 0.5
eta_a = 0.7

Z_eff = 1.5
rho_m = 0.6
A = 2.5

f_DT = 0.9

wave_theta = 0.0
wave_gamma0 = 8.562
wave_error_level = 5e-3

eta_cd_attempts = 25

shape_sigma = 0.1

default_eta_CD = 0.35

max_beta_N = 0.026
max_P_W = 2.5

enable_bremsstrahlung = true
enable_eta_CD_derive = true
enable_blanket_derive = true
enable_cold_mass_calc = true

use_slow_sigma_v_funcs = true
use_bosch_hale_sigma_v = true

integral_delta = 1e-4

integral_zero = 0.0 + integral_delta
integral_one = 1.0 - integral_delta

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

alphas = confinement_scaling

symbol_list = []

append!(symbol_list, ["eta_CD"])
append!(symbol_list, ["T_k", "R_0", "B_0"])
append!(symbol_list, ["I_M", "n_bar", "tau_E"])
append!(symbol_list, ["sigma_v_hat", "K_CD_denom"])
append!(symbol_list, ["beta_N", "P_W", "h_parallel"])

symbol_dict = Dict()
for cur_symbol in symbol_list
  symbol_dict[cur_symbol] = symbols(cur_symbol, positive=true)
end

eta_CD = symbol_dict["eta_CD"]

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
