struct EquationSet <: AbstractEquationSet
  eq_1::AbstractEquation
  eq_2::AbstractEquation
  eq_3::AbstractEquation

  R_0::AbstractSymbol
  B_0::AbstractSymbol
  I_P::AbstractSymbol
end

function EquationSet(cur_reactor::AbstractReactor, secondary_constraint::AbstractEquation)
  primary_constraint = power_balance_equation(cur_reactor)

  tertiary_constraint = T_bar_equation(cur_reactor, symbols(:T_bar_const))

  cur_equations = [primary_constraint, secondary_constraint, tertiary_constraint]

  cur_variable_list = [:R_0, :B_0]
  cur_indices = [1, 2]

  cur_gamma_RBI = cur_equations[first(cur_indices)].R_0 * cur_equations[last(cur_indices)].B_0

  cur_gamma_RBI -= cur_equations[last(cur_indices)].R_0 * cur_equations[first(cur_indices)].B_0

  cur_dict = OrderedDict()

  cur_I_P = safe_get(cur_reactor, :I_P)

  is_bad_I_P = !isa(cur_I_P, SymEngine.Basic) && cur_I_P < 0

  for (cur_index, cur_variable) in enumerate(cur_variable_list)
    if is_bad_I_P
      cur_dict[cur_variable] = NaN
      continue
    end

    other_variables = [ cur_variable_list[cur_index+1:end]..., cur_variable_list[1:cur_index-1]... ]

    cur_formula = 1.0

    for cur_sub_index in cur_indices
      other_indices = [ cur_indices[cur_sub_index+1:end]..., cur_indices[1:cur_sub_index-1]... ]

      cur_exponent = (
        getfield(cur_equations[first(other_indices)], first(other_variables))
      )

      ( cur_index == cur_sub_index ) ||
        ( cur_exponent *= -1 )

      cur_formula *= cur_equations[cur_sub_index].G_T ^ cur_exponent

      cur_formula /= cur_I_P ^ ( cur_exponent * cur_equations[cur_sub_index].I_P )
    end

    if !isa(cur_formula, SymEngine.Basic) && cur_formula < 0
      cur_formula = NaN
    else
      cur_formula ^= ( 1 / cur_gamma_RBI )
    end

    cur_dict[cur_variable] = cur_formula
  end

  cur_equation_set = EquationSet(
    cur_equations..., values(cur_dict)..., symbols(:I_P)
  )

  cur_equation_set
end

function EquationSet(cur_reactor::AbstractReactor, secondary_constraint::AbstractEquation, tertiary_constraint::AbstractEquation)
  primary_constraint = power_balance_equation(cur_reactor)

  cur_equations = [primary_constraint, secondary_constraint, tertiary_constraint]

  cur_variable_list = [:R_0, :B_0, :I_P]
  cur_indices = [1, 2, 3]

  cur_gamma_RBI = 0.0

  for cur_index in cur_indices
    other_indices = [ cur_indices[cur_index+1:end]..., cur_indices[1:cur_index-1]... ]

    cur_sub_gamma = cur_equations[first(other_indices)].B_0 * cur_equations[last(other_indices)].I_P

    cur_sub_gamma -= cur_equations[last(other_indices)].B_0 * cur_equations[first(other_indices)].I_P

    cur_sub_gamma *= cur_equations[cur_index].R_0

    cur_gamma_RBI += cur_sub_gamma
  end

  cur_dict = OrderedDict()

  for (cur_index, cur_variable) in enumerate(cur_variable_list)
    other_variables = [ cur_variable_list[cur_index+1:end]..., cur_variable_list[1:cur_index-1]... ]

    cur_formula = 1.0

    for cur_sub_index in cur_indices
      other_indices = [ cur_indices[cur_sub_index+1:end]..., cur_indices[1:cur_sub_index-1]... ]

      cur_exponent = (
        getfield(cur_equations[first(other_indices)], first(other_variables)) *
        getfield(cur_equations[last(other_indices)], last(other_variables))
      )

      cur_exponent -= (
        getfield(cur_equations[first(other_indices)], last(other_variables)) *
        getfield(cur_equations[last(other_indices)], first(other_variables))
      )

      cur_G_T = cur_equations[cur_sub_index].G_T

      if !isa(cur_G_T, SymEngine.Basic) && cur_G_T < 0
        cur_formula = NaN
      else
        cur_formula *= cur_G_T ^ cur_exponent
      end
    end

    cur_formula ^= ( 1 / cur_gamma_RBI )

    cur_dict[cur_variable] = cur_formula
  end

  cur_equation_set = EquationSet(
    cur_equations..., values(cur_dict)...
  )

  cur_equation_set
end

function equation_set_dict(cur_equation_set::EquationSet)
  cur_dict = Dict()

  cur_dict[symbols(:R_0)] = cur_equation_set.R_0
  cur_dict[symbols(:B_0)] = cur_equation_set.B_0

  ( cur_equation_set.I_P == symbols(:I_P) ) && return cur_dict

  cur_dict[symbols(:I_P)] = cur_equation_set.I_P

  cur_dict
end
