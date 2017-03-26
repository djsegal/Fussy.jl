main_folder = pwd()

loaded_folders = [ "config/initializers", "src" ]

for loaded_folder in loaded_folders
  loaded_folder = "$main_folder/$loaded_folder"

  Julz.include_all_files(loaded_folder)
  @eval Julz.@export_all_files $loaded_folder
end

