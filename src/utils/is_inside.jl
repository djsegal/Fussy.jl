function is_inside(cur_x::Number, cur_a::Number, cur_b::Number)
  ( cur_a <= cur_x <= cur_b ) && return true
  ( cur_a >= cur_x >= cur_b ) && return true
  false
end
