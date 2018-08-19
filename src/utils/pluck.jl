function _pluck(cur_array::AbstractArray, remove_item=false)
  cur_length = length(cur_array)
  ( iszero(cur_length) ) && throw(BoundsError())

  cur_index = rand(1:cur_length)
  cur_value = cur_array[cur_index]

  remove_item && deleteat!(cur_array, cur_index)

  cur_value
end

function pluck(cur_array::AbstractArray)
  _pluck(cur_array, false)
end

function pluck!(cur_array::AbstractArray)
  _pluck(cur_array, true)
end

function pluck(cur_iterator::Union{Base.KeyIterator, Base.ValueIterator})
  pluck(collect(cur_iterator))
end
