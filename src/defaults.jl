const integral_offset = 1e-8

const integral_zero = 0.0 + integral_offset
const integral_one = 1.0 - integral_offset

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
const E_L = 4.8
