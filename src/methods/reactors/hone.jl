function hone(cur_reactor::AbstractReactor, cur_constraint::Symbol, cur_value::Union{Void, Number}=nothing; reltol::Number=3e-3, max_attempts::Int = 10, strong_fail::Bool = false)
  ( cur_value == nothing ) && @assert cur_reactor.constraint == :beta

  cur_reactor.is_good || return nothing

  prev_T = nothing
  prev_eta_CD = nothing
  cur_error = NaN

  honed_reactor = nothing

  work_reactor = deepcopy(cur_reactor)

  for cur_index in 1:max_attempts
    prev_T = work_reactor.T_bar
    prev_eta_CD = work_reactor.eta_CD

    if cur_value == nothing
      new_reactor = match(work_reactor, cur_constraint)
    else
      new_reactor = match(work_reactor, cur_constraint, cur_value)
    end

    ( new_reactor == nothing ) && return nothing

    if cur_index > 1
      tmp_T_list = [prev_T, work_reactor.T_bar]
      tmp_eta_CD_list = [prev_eta_CD, work_reactor.eta_CD]

      cur_T_error = 1 - minimum(tmp_T_list)/maximum(tmp_T_list)
      cur_eta_CD_error = 1 - minimum(tmp_eta_CD_list)/maximum(tmp_eta_CD_list)

      cur_error = max(cur_T_error, cur_eta_CD_error)

      if cur_error < reltol
        new_reactor.is_valid || break
        new_reactor.is_good || break

        honed_reactor = new_reactor
        break
      end
    end

    work_reactor.T_bar = new_reactor.T_bar

    tmp_reactor = deepcopy(work_reactor)

    cur_eta_CD_list = converge(tmp_reactor, no_pts=Int(ceil(no_pts_eta_CD/2)))

    if isempty(cur_eta_CD_list)
      solved_reactor = solve!(tmp_reactor)
      solved_reactor.is_valid || return nothing
      solved_reactor.is_good || return nothing

      work_eta_CD = calc_eta_CD(solved_reactor)
      isnan(work_eta_CD) && return nothing
      cur_eta_CD_list = [ work_eta_CD ]
    else
      filter_approx!(cur_eta_CD_list, atol=3e-3)
    end

    if strong_fail
      @assert length(cur_eta_CD_list) == 1
    else
      if length(cur_eta_CD_list) != 1
        custom_log("Too many eta CD values")
        custom_log(cur_eta_CD_list)
        custom_log(new_reactor)
      end
    end

    work_reactor.eta_CD += cur_eta_CD_list[1]
    work_reactor.eta_CD /= 2
  end

  ( honed_reactor == nothing ) && return nothing

  @assert honed_reactor.is_valid
  @assert honed_reactor.is_good

  honed_reactor
end
