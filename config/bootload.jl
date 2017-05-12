main_folder = "$(dirname(@__FILE__))/.."

loaded_folders = [ "config/initializers", "src" ]

for loaded_folder in loaded_folders
  loaded_folder = "$main_folder/$loaded_folder"

  Julz.include_all_files(loaded_folder, package_name="Tokamak")
  @eval Julz.@export_all_files $loaded_folder
end

function load_input(raw_input, is_file_input=false)
  if is_file_input
    file_path = "$main_folder/$raw_input"

    if !isfile(file_path)
      file_path = "$main_folder/lib/input_decks/$raw_input"
    end

    open(file_path) do file
      file_lines = map(x -> split(x, "#")[1], readlines(file))
      file_lines = map(x -> strip(x), file_lines)

      raw_input = join(file_lines, ";")

      raw_input = replace(raw_input, "(;", "(")
      raw_input = replace(raw_input, ",;", ",")

      raw_input *= "; nothing ;"
    end
  end

  eval( parse(raw_input) )
end

defaults_file_name = "defaults.jl"
load_input(defaults_file_name, true)
