"""
    MWh_electric_per_year()

Lorem ipsum dolor sit amet.
"""
function MWh_electric_per_year()
  ElecProd = zeros(2, plant_life + construction_time)

  ElecProd[1,construction_time+1:end] = fill!(zeros(1, plant_life), econ_availability * econ_MW_e() * 365 * 24)

  # discount electricity per year
  for i = 1:(construction_time + plant_life)
    ElecProd[2,i] = ElecProd[1,i] / ( 1.0 + discount_rate )^i
  end

  ElecProd
end
