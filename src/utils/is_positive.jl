is_positive(cur_value::SymEngine.Basic) = true

is_positive(cur_value::Any) = ( cur_value > 0 )
