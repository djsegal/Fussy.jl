"""
    LineItem(name, price_per, quantity, fab_factor)

Lorem ipsum dolor sit amet.
"""
type LineItem

  name::AbstractString

  price_per::Float64
  quantity::Float64
  fab_factor::Float64

  LineItem(name::AbstractString) =
    new(name::AbstractString, 1.0, 1.0, 1.0)

end
