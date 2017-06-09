"""
    elliptice(cur_val)

Lorem ipsum dolor sit amet.
"""
function elliptice(cur_val)

  if eltype(cur_val) == SymPy.Sym

    return sympy_meth(:elliptic_e, cur_val)

  end

  Elliptic.E(cur_val)

end
