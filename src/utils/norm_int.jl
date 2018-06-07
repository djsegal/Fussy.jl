function norm_int(cur_func::Function)
  cur_integral = QuadGK.quadgk(
    cur_func, integral_zero, integral_one
  )

  cur_value = cur_integral[1]

  cur_value
end

function norm_int(cur_func::SymEngine.Basic)
  [1, cur_func]
end
