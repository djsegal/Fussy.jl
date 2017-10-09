"""
    solved_B_0_from_constraint(main_value, side_guess, cur_eta_CD, cur_eq, verbose)

Lorem ipsum dolor sit amet.
"""
function solved_B_0_from_constraint(main_value, side_guess, cur_eta_CD, cur_eq, verbose)

  solved_B_0 = NaN

  solved_B_0 = calc_possible_values(
    cur_eq,
    cur_T_k = main_value * 1u"keV",
    cur_eta_CD = cur_eta_CD
  )

  solved_B_0 *= 1u"T"

  solved_B_0

end
