is_nan(cur_value::Number) = isnan(cur_value)

function is_nan(cur_value::SymEngine.Basic)
  isempty(free_symbols(cur_value)) || return false

  isnan(N(cur_value))
end

is_finite(cur_value::Number) = isfinite(cur_value)

function is_finite(cur_value::SymEngine.Basic)
  isempty(free_symbols(cur_value)) || return true
  is_nan(cur_value) && return false

  isfinite(N(cur_value))
end
