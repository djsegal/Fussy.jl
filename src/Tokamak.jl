module Tokamak

  using Julz

  @reexport using QuadGK
  @reexport using SymPy
  @reexport using NLsolve
  @reexport using Elliptic
  @reexport using Polynomials
  @reexport using DataFrames
  @reexport using Interpolations
  @reexport using YAML
  @reexport using Memoize
  @reexport using ForwardDiff
  @reexport using Plasmas
  @reexport using StaticArrays

  Base.cd("$(dirname(@__FILE__))/..") do
    include("../config/bootload.jl")
  end

convert(::Type{SVector{10,Char}}, x::AbstractString) = SVector{10,Char}(split(x, ""))

  function main(B_list=linspace(5,15,6))
    load_input("arc.jl", true)
    load_input("input.jl", true)

    load_input(" enable_eta_CD_derive = true ")
    load_input(" use_slow_sigma_v_funcs = true ")
    load_input(" use_bosch_hale_sigma_v = true ")

    output_file_name = "output.jl"

    if isfile(output_file_name) ; rm(output_file_name) ; end

    solved_equations = sweep_B_0(B_list)

    solution_dict = OrderedDict()

    data_var_keys = [
      "R_0" , "B_0" , "T_k" , "eta_CD",
      "primary_constraint", "secondary_constraint"
    ]

    for (cur_index, cur_B) in enumerate(B_list)
      cur_data = OrderedDict()

      for cur_var_key in data_var_keys
        cur_data[cur_var_key] = solved_equations[cur_var_key][cur_index]
      end

      solution_dict[cur_B] = analyze_solved_case(cur_data, verbose=false)
    end

    all_var_keys = keys(first(values(solution_dict)))

    open(output_file_name, "w") do cur_file
      for cur_key in all_var_keys
        cur_array = map(x -> string(x[cur_key]), values(solution_dict))

        if cur_key != "primary_constraint" && cur_key != "secondary_constraint"
          cur_line = "$cur_key = [ $(join(cur_array, " , ")) ]\n"

          write(cur_file, cur_line)
          continue
        end

        transition_index = findfirst(
          cur_constraint -> cur_constraint != first(cur_array),
          cur_array
        )

        if transition_index == 0
          cur_line = "transition = []\n"

          write(cur_file, cur_line)
          continue
        end

        cur_points = [ cur_key for cur_key in keys(solution_dict) ]

        transition_value = cur_points[transition_index]
        transition_value -= cur_points[transition_index-1]
        transition_value /= 2

        transition_value += cur_points[transition_index-1]

        cur_line = "transition = [ $transition_value ]\n"

        write(cur_file, cur_line)
      end
    end

    println("done.")
  end

end
