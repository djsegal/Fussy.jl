"""
    construction_distribution()

Lorem ipsum dolor sit amet.
"""
function construction_distribution()

  dummy_years = linspace(1, length(parson_distribution), construction_time)

  cur_grid = InterpGrid(parson_distribution, BCnil, InterpLinear)

  mapped_grid = map( x -> cur_grid[x] , dummy_years )

  construct_dist = mapped_grid

  construct_dist /= sum(mapped_grid)

  construct_dist

end
