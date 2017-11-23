"""
    p_bar()

Lorem ipsum dolor sit amet.
"""
function p_bar()
  cur_p_bar = 0.1602

  cur_p_bar *= ( 1 + f_DT )

  cur_p_bar *= ( 1 + nu_n )

  cur_p_bar *= ( 1 + nu_T )

  cur_p_bar /= ( 1 + nu_n + nu_T )

  cur_p_bar *= ( n_bar / 1u"n20" )

  cur_p_bar *= ( T_k / 1u"keV" )

  cur_p_bar *= 1u"bar"

  cur_p_bar
end
