function norm_int(cur_func::Function)
  cur_integral = nothing

  try
    cur_integral = quadgk(
      cur_func, integral_zero, integral_one
    )[1]
  catch cur_error
    isa(cur_error, DomainError) || rethrow(cur_error)
    cur_integral = NaN
  end

  cur_integral
end

function norm_int(cur_func::SymEngine.Basic)
  [1, cur_func]
end

