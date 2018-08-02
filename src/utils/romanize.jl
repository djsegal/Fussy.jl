function romanize(cur_int::Integer)
  @assert cur_int < 9

  ( cur_int < 4 ) && return "I" ^ cur_int
  ( cur_int == 4 ) && return "IV"

  cur_string = "V"
  cur_string *= "I" ^ ( cur_int - 5 )
  cur_string
end
