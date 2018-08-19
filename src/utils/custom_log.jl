function custom_log(vargs...; kwargs...)
  __is_logging || return
  println(vargs...; kwargs...)
  sleep(0.1)
end
