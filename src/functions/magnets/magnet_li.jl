@doc """
    magnet_li()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_li()
  rm = 0.6
  alpha = 1/(1-rm^2)

  int1 = 1/4*(exp(2.*alpha).*(2.*alpha-1)+1)
  int2 = (1+alpha).*(1-exp(2.*alpha))
  int3 = 2*(1+alpha).*(exp(alpha)-1)
  int4 = 27

  li = 1./(exp(alpha)-1-alpha).^2.*(int1+int2+int3+int4)

  li
end
