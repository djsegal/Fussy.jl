@doc """
    Vol_PF()

Volume of PF Coils (HTS and Structure).
"""
@memoize function Vol_PF()

  cur_Vol_PF = sum( Vsc_PF() )

  cur_Vol_PF += sum( Vst_PF() )

  cur_Vol_PF

end
