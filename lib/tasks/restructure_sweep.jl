"""
    restructure_sweep()

Lorem ipsum dolor sit amet.
"""
function restructure_sweep(old_sweep)
  num_runs = length(first(values(old_sweep)))

  new_sweep = Array{Any}(num_runs)

  for cur_index in 1:length(new_sweep)
    new_sweep[cur_index] = OrderedDict()

    for (cur_key, cur_value) in old_sweep
      if eltype(cur_value) == Pair{Any,Any}
        new_sweep[cur_index][cur_key] = OrderedDict()

        for (cur_sub_key, cur_sub_value) in cur_value
          new_sweep[cur_index][cur_key][cur_sub_key] = cur_sub_value[cur_index]
        end

        continue
      end

      new_sweep[cur_index][cur_key] = cur_value[cur_index]
    end
  end

  filter!(cur_run -> cur_run["success"], new_sweep)

  new_sweep
end
