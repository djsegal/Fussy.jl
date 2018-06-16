@symbol_func function phi_ind(cur_reactor::AbstractReactor)
  cur_phi = phi_RU(cur_reactor)

  cur_phi -= phi_res(cur_reactor)

  cur_phi
end
