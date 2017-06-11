@doc """
    Area_HTS()

Area of HTS in winding pack.
"""
@memoize function Area_HTS()

  cur_Area_HTS = Tape_w

  cur_Area_HTS ^= 2

  cur_Area_HTS

end
