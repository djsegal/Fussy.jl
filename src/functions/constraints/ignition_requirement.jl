"""
    ignition_requirement()

Lorem ipsum dolor sit amet.
"""
function ignition_requirement()
  cur_ignition_requirement = lawson_criterion()
  cur_ignition_requirement -= simplified_n_bar_tau_E()

  cur_ignition_requirement /= 1u"s"
  cur_ignition_requirement /= 1u"n20"

  cur_ignition_requirement
end
