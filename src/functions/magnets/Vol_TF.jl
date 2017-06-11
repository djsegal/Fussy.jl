@doc """
    Vol_TF()

Lorem ipsum dolor sit amet.
"""
@memoize function Vol_TF()

  cur_Vol_TF = Vol_WP()

  cur_Vol_TF += V_TF()

  cur_Vol_TF

end
