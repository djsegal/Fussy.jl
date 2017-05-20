"""
    construction_distribution()

Lorem ipsum dolor sit amet.
"""
function construction_distribution()
  parson_dist = [ 0.1 , 0.2 , 0.4 , 0.2 , 0.1 ]

  dummy_years = linspace(1, length(parson_dist), construction_time)
  cur_grid = InterpGrid(parson_dist, BCnil, InterpLinear)

  y = map( x -> cur_grid[x] , dummy_years )
  ConstructDist = y / sum(y)

  ConstructDist
end
