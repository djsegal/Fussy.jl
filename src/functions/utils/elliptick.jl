"""
    elliptick(cur_val)

Lorem ipsum dolor sit amet.
"""
function elliptick(cur_val)

  if eltype(cur_val) == SymPy.Sym

    return sympy_meth(:elliptic_k, cur_val)

  end

  Elliptic.K(cur_val)

end
