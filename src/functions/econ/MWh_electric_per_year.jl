"""
    MWh_electric_per_year()

Discount electricity per year.
"""
function MWh_electric_per_year()

  total_years = construction_time + plant_life

  cur_prod = Array{Any}(2, total_years)

  fill!(cur_prod, 0.0)

  cur_prod[1, construction_time+1:end] = econ_availability * econ_MW_e() * 365 * 24

  for cur_year in 1:total_years

    cur_prod[2, cur_year] = cur_prod[1, cur_year]

    cur_prod[2, cur_year] /= ( 1.0 + discount_rate ) ^ cur_year

  end

  cur_prod

end
