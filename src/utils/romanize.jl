function romanize(cur_int::Integer)
  @assert cur_int < 19

  if cur_int < 9
    ( cur_int < 4 ) && return "I" ^ cur_int
    ( cur_int == 4 ) && return "IV"

    cur_string = "V"
    cur_string *= "I" ^ ( cur_int - 5 )
    cur_string
  else
    ( cur_int == 9 ) && return "IX"

    cur_string = "X"
    ( cur_int < 14 ) && return cur_string * ( "I" ^ ( cur_int - 10 ) )
    ( cur_int == 14 ) && return "XIV"

    cur_string *= "V"
    cur_string *= "I" ^ ( cur_int - 5 - 10 )
    cur_string
  end
end
