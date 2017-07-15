"""
    @generate_fusion_equation_set

Lorem ipsum dolor sit amet.
"""
macro generate_fusion_equation_set(cur_eq)
  quote
    function (cur_var, cur_F)
      cur_T_k = cur_var[1] * 1u"keV"

      cur_F[1] = calc_possible_values( $(esc(cur_eq)), cur_T_k=cur_T_k )

      cur_F
    end
  end
end
