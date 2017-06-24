"""
    dememoize()

Lorem ipsum dolor sit amet.
"""
function dememoize()

  mod = current_module()

  all_caches = filter( x ->
    startswith(string(x), "##") &&
    endswith(string(x),"_memoized_cache"),
    names(mod, true)
  )

  for cur_cache_symbol in all_caches
    empty!(getfield(mod, cur_cache_symbol))
  end

end
