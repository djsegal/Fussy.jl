function sort_lists!(main_list, other_lists...; cur_func::Function=identity)
  cur_indices = sortperm(main_list, by=cur_func)

  cur_list = collect(main_list)[cur_indices]
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
  cur_lists = Any[ isa(main_list, Vector) ? main_list : collect(main_list) ]
  isempty(other_lists) || append!(cur_lists, other_lists)

  for cur_list in cur_lists
      cur_list .= cur_list[cur_indices]
  end
  main_list
end

function bisect_reorder!(cur_vector::Vector)
  cur_indices = breadth_indices(length(cur_vector))
  cur_vector .= cur_vector[cur_indices]
  cur_vector
end

function collect_bisection_indexes!(ix, level, a, b)
    a ≤ b || return
    mid = (a+b) ÷ 2
    push!(ix, level => mid)
    collect_bisection_indexes!(ix, level + 1, a, mid - 1)
    collect_bisection_indexes!(ix, level + 1, mid + 1, b)
end

function breadth_indices(n)
    ix = Vector{Pair{Int,Int}}()
    sizehint!(ix, n)
    collect_bisection_indexes!(ix, 0, 1, n)
    last.(sort!(ix, by = first))
end

function out_in_reorder!(cur_vector::Vector)
  cur_indices = centering_indices(length(cur_vector))
  cur_vector .= cur_vector[cur_indices]
  cur_vector
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

function in_out_reorder!(cur_vector::Vector)
  cur_indices = dividing_indices(length(cur_vector))
  cur_vector .= cur_vector[cur_indices]
  cur_vector
end

function dividing_indices(num_points::Number)
  cur_indices = []

  cur_half_point = Int(floor(num_points/2))

  isodd(num_points) && push!(cur_indices, cur_half_point+1)
  for cur_index in reverse(1:cur_half_point)
    push!(cur_indices, cur_index)
    push!(cur_indices, num_points-(cur_index-1))
  end

  cur_indices
end
