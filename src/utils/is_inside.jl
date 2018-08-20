function is_inside(cur_x::Number, cur_a::Number, cur_b::Number; inclusive::Bool=true)
  if inclusive
    ( cur_a <= cur_x <= cur_b ) && return true
    ( cur_a >= cur_x >= cur_b ) && return true
  else
    ( cur_a < cur_x < cur_b ) && return true
    ( cur_a > cur_x > cur_b ) && return true
  end

  false
end
