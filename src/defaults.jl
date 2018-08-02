const integral_offset = 1e-8

const integral_zero = 0.0 + integral_offset
const integral_one = 1.0 - integral_offset

const min_I_P = 0
const max_I_P = 75
const no_pts_I_P = 151

const min_eta_CD = 0.0
const max_eta_CD = 1.0
const no_pts_eta_CD = 31

const min_rho = 0.0 + 1e-8
const max_rho = 1.0 - 1e-8
const no_pts_rho = 21

const min_T_bar = 3.0
const max_T_bar = 36.0
const no_pts_T_bar = 51

const max_roots = 10

const H_mode_scaling = Dict(
  :constant => 0.1445,
  :I => 0.93,
  :R => 1.39,
  :a => 0.58,
  :kappa => 0.78,
  :n => 0.41,
  :B => 0.15,
  :A => 0.19,
  :P => 0.69
)

const L_mode_scaling = Dict(
  :constant => 0.0578,
  :I => 0.96,
  :R => 1.89,
  :a => -0.06,
  :kappa => 0.64,
  :n => 0.40,
  :B => 0.03,
  :A => 0.20,
  :P => 0.73
)

const scaling_keys = keys(H_mode_scaling)

const E_F = 17.6
const E_Li = 4.8

const reduced_mass = 1.124656e6

const gamov_const = 34.3827

const bosch_hale_coeffs = [
  +1.17302e-9,
  +1.51361e-2,
  +7.51886e-2,
  +4.60643e-3,
  +1.35000e-2,
  -1.06750e-4,
  +1.36600e-5
]

const secondary_limits = OrderedDict(
  :beta => "TB",
  :kink => "KF",
  :pcap => "PC",
  :wall => "WL",
  :heat => "DV"
)

const secondary_params = OrderedDict(
  :beta => "beta_N",
  :kink => "q_95",
  :pcap => "P_E",
  :wall => "P_W",
  :heat => "q_DV"
)

const wave_gamma = 8.562

const wave_M = 1.0

const wave_n = 0.77

const wave_m = 1.38

const wave_x_r = 2.47

const wave_c = 0.778

