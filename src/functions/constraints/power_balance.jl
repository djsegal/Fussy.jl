"""
    power_balance()

Lorem ipsum dolor sit amet.
"""
function power_balance()
  cur_power_balance = power_sources()

  cur_power_balance -= power_sinks()

  cur_power_balance
end
