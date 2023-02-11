class Commander
  def call
  end
end


# recycle_bin = RecycleBin.new
# recycle_bin.initialize_bin
# file_name = gets.chomp
# recycle_bin.file_to_bin(file_name)


# @@printer = Printer.new(false)
# # @@deserializer = Deserializer.new

# def initialize_bin
#   if !Dir.exist?(RECYCLE_BIN_PATH)
#     Dir.mkdir(RECYCLE_BIN_PATH)
#     @@printer.call('The recycle bin has just been created.')
#   end
# end

# def file_to_bin(file_name)
#   if File.exist?(file_name)
#     file = FileObject.new(file_name, Time.now, File.expand_path('.'))
#     FileUtils.mv(file.file_name, RECYCLE_BIN_PATH)
#     RemovedFilesTracker.new.add_to_files_tracker(file)
#     return @@printer.call("#{file_name} has been moved to the recycle bin.")
#   else
#     return @@printer.call("No file '#{file_name}' was found in #{Dir.pwd}")
#   end
# end

# def restore_from_bin
#   # file = File.read('.files_tracker.json')
#   # removed_files_in_json = JSON.parse(file)
#   # p *removed_files_in_json
#   # restored_object = FileObject.new(" ", 12.12, "...")
#   # restored_object.deserialize_log
# end

# def delete_all_from_bin
#   if Dir.empty?(RECYCLE_BIN_PATH)
#     puts 'The recycle bin is already empty. Aborting program'
#     exit
#   end
#   puts 'Are you sure you want to empty the bin? Type \'yes\' to continue. Press any button to break.'
#   confirmation = gets.chomp.downcase
#   if confirmation == 'yes'
#     Dir.each_child(RECYCLE_BIN_PATH) do |file_name|
#     file_to_delete = File.join(RECYCLE_BIN_PATH, file_name)
#     puts file_to_delete
#     File.delete(file_to_delete) if File.exist?(file_to_delete)
#     end
#     puts 'The bin is now empty'
#   else
#     @@printer.call('Aborting the program.')
#     exit
#   end
# end

# def delete_file_from_bin
#   if Dir.children(RECYCLE_BIN_PATH).empty?
#     puts 'The recycle bin is empty. Aborting the program'
#     exit
#   end
#   print_bin_contents
#   puts 'Which file would you like to delete? Insert a correct full name with extension of the file'
#   found_to_delete = false
#   file_to_delete_name = gets.chomp
#   Dir.each_child(RECYCLE_BIN_PATH) do |file_name|
#     next if file_name != file_to_delete_name
#     file_to_delete = File.join(RECYCLE_BIN_PATH, file_to_delete_name)
#     puts "Are you sure that you want to delete #{file_to_delete}? Type 'yes' to continue. Press any button to break."
#     found_to_delete = true
#     choice = gets.chomp.downcase
#     case choice
#     when 'yes'
#       File.delete(file_to_delete) if File.exist?(file_to_delete)
#       puts "The file #{file_to_delete_name} has been deleted. What would you like to do next?"
#       puts "Type '1' to delete another file from the recycle bin. Press any button to break."
#       choice1 = gets.chomp.to_i
#       case choice1
#       when 1
#         delete_file_from_bin
#       else
#         @@printer.call('Aborting the program.')
#         exit
#       end
#     else
#       @@printer.call('Aborting the program.')
#       exit
#     end
#   end
#   if !found_to_delete
#     puts "Such file doesn't exist in #{RECYCLE_BIN_PATH}."
#     puts "Type '1' to try again. Press any button to abort the program."
#     choice2 = gets.chomp
#     case choice2.to_i
#     when 1
#       delete_file_from_bin
#     else
#       @@printer.call('Aborting program.')
#       exit
#     end
#   end
# end

# def print_bin_contents
#   puts 'The contents in recycle bin:'
#   puts '_________________________'
#   puts Dir.each_child(RECYCLE_BIN_PATH) { |file| puts file }
#   puts '_________________________'
# end
