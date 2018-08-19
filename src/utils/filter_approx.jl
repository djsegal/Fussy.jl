function filter_approx!(cur_vector; atol=5e-2)
  delete_indices = []

  for (cur_index, cur_value) in enumerate(cur_vector)
    is_duplicate = any(
      tmp_value -> isapprox(tmp_value, cur_value, atol=atol),
      cur_vector[1:cur_index-1]
    )

    is_duplicate || continue
    push!(delete_indices, cur_index)
  end

  deleteat!(cur_vector, delete_indices)

  cur_vector
end

function approx_push!(cur_vector, cur_value; atol=5e-2)
  is_duplicate = any(
    tmp_value -> isapprox(tmp_value, cur_value, atol=atol),
    cur_vector
  )

  is_duplicate && return cur_vector
  push!(cur_vector, cur_value)
end

function approx_append!(cur_vector, other_vector; atol=5e-2)
  append!(cur_vector, other_vector)
  filter_approx!(cur_vector; atol=atol)

  cur_vector
end
