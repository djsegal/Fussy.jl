"""
    solve_wave_equations(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, cur_solved_n_bar; verbose=false)

Lorem ipsum dolor sit amet.
"""
function solve_wave_equations(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, cur_solved_n_bar; verbose=false)
  cur_rho = nothing

  cur_eq = @generate_wave_equation_set(
    cur_solved_R_0,
    cur_solved_B_0,
    cur_solved_T_k,
    cur_solved_n_bar
  )

  for cur_attempt in 1:3
    did_work = true

    cur_rand_value = 0.1 + 0.8 * rand()

    try
      cur_rho = nlsolve(
        cur_eq, [cur_rand_value], #[-1.0], [+1.0], [cur_rand_value],
        iterations = 100,
        show_trace = false
      ).zero[1]

      cur_rho = abs(cur_rho)
    catch DomainError
      did_work = false
    end

    if verbose ; print( did_work ? "+" : "*" ) ; end

    if did_work ; break ; end
  end

  if cur_rho == nothing
    if verbose ; print("o") ; end
    return NaN
  end

  cur_rho
end
