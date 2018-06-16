const integral_offset = 1e-8

const integral_zero = 0.0 + integral_offset
const integral_one = 1.0 - integral_offset

const min_I_P = 0.25
const max_I_P = 250

const h_mode_scaling = Dict(
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

const scaling_keys = keys(h_mode_scaling)

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
