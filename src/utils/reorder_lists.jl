function sort_lists!(main_list, other_lists...; cur_func::Function=identity)
  cur_indices = sortperm(main_list, by=cur_func)

  cur_list = main_list[cur_indices]
  _arrange_lists!(main_list, other_lists, cur_indices)
  cur_list
end

function shuffle_lists!(main_list, other_lists...)
  cur_indices = shuffle(1:length(main_list))

  cur_list = main_list[cur_indices]
  _arrange_lists!(main_list, other_lists, cur_indices)
  cur_list
end

function _arrange_lists!(main_list, other_lists, cur_indices)
  cur_lists = Any[ collect(main_list) ]
  isempty(other_lists) || append!(cur_lists, other_lists)

  for cur_list in cur_lists
      cur_list .= cur_list[cur_indices]
  end
end

function bisect_reorder!(cur_vector::Vector)
  cur_indices = breadth_indices(length(cur_vector))
  cur_vector .= cur_vector[cur_indices]
end

function breadth_indices(num_points::Number)
  cur_indices = []

  cur_step = num_points
  while length(cur_indices) < num_points - 1
    cur_step = Int(floor( (cur_step-1) / 2 )) + 1
    @assert !iszero(cur_step)

    for cur_index in 1:num_points-1
      iszero( cur_index % cur_step ) || continue
      in(cur_index, cur_indices) && continue
      push!(cur_indices, cur_index)
    end
  end
  push!(cur_indices, num_points)

  cur_indices
end

function out_in_reorder!(cur_vector::Vector)
  cur_indices = centering_indices(length(cur_vector))
  cur_vector .= cur_vector[cur_indices]
end

function centering_indices(num_points::Number)
  cur_indices = []

  cur_half_point = Int(floor(num_points/2))
  for cur_index in 1:cur_half_point
    push!(cur_indices, cur_index)
    push!(cur_indices, num_points-(cur_index-1))
  end
  isodd(num_points) && push!(cur_indices, cur_half_point+1)

  cur_indices
end
