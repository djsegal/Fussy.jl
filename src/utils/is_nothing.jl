is_nothing(cur_object) = false
is_nothing(cur_object::Void) = true

is_present(cur_object) = !is_nothing(cur_object)
