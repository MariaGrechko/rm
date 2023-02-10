require 'fileutils'
require_relative './file_object.rb'
require_relative './removed_files_tracker.rb'
require_relative './command_line.rb'

class RecycleBin
  RECYCLE_BIN_PATH = File.expand_path('~/.recycle_bin')
  @@command_line = CommandLine.new

  def initialize_bin
    if !Dir.exist?(RECYCLE_BIN_PATH)
      Dir.mkdir(RECYCLE_BIN_PATH)
      @@command_line.creation_message(true)
    end
  end

  def file_to_bin(file_name)
    if File.exist?(file_name)
      file = FileObject.new(file_name, Time.now, File.expand_path('.'))
      FileUtils.mv file.file_name, RECYCLE_BIN_PATH
      puts "Hopefully, the file #{file_name} is now to be found in #{RECYCLE_BIN_PATH}"
      creator = RemovedFilesTracker.new
      json_arr = []
      json_arr << file.to_json
      creator.add_to_files_tracker(json_arr)
      print_bin_contents
    else
      puts "No file '#{file_name}' was found in #{Dir.pwd}"
    end
  end

  def delete_all_from_bin
    if Dir.empty?(RECYCLE_BIN_PATH)
      puts 'The recycle bin is already empty. Aborting program'
      exit
    end
    puts 'Are you sure you want to empty the bin? The data will not be restored. Type \'yes\' to continue.'
    confirmation = gets.chomp.downcase
    if confirmation == 'yes'
      Dir.each_child(RECYCLE_BIN_PATH) do |file_name|
      file_to_delete = File.join(RECYCLE_BIN_PATH, file_name)
      puts file_to_delete
      File.delete(file_to_delete) if File.exist?(file_to_delete)
      end
      puts 'The bin is now empty'
    else
      puts 'Canceling operation.'
      exit
    end
  end

  def delete_file_from_bin
    if Dir.children(RECYCLE_BIN_PATH).empty?
      puts 'The recycle bin is empty. Aborting the program'
      exit
    end
    print_bin_contents
    puts 'Which file would you like to delete? Insert a correct full name with extension of the file'
    found_to_delete = false
    file_to_delete_name = gets.chomp
    Dir.each_child(RECYCLE_BIN_PATH) do |file_name|
      next if file_name != file_to_delete_name
      file_to_delete = File.join(RECYCLE_BIN_PATH, file_to_delete_name)
      puts "Are you sure that you want to delete #{file_to_delete}? Type 'yes' to continue. Press any button to break."
      found_to_delete = true
      choice = gets.chomp.downcase
      case choice
      when 'yes'
        File.delete(file_to_delete) if File.exist?(file_to_delete)
        puts "The file #{file_to_delete_name} has been deleted. What would you like to do next?"
        puts "Type '1' to delete another file from the recycle bin. Press any button to break."
        choice1 = gets.chomp.to_i
        case choice1
        when 1
          delete_file_from_bin
        else
          @@command_line.aborting_program(true)
          exit
        end
      else
        puts 'Canceling operation.'
        exit
      end
    end
    if !found_to_delete
      puts "Such file doesn't exist in #{RECYCLE_BIN_PATH}."
      puts "Type '1' to try again. Press any button to abort the program."
      choice2 = gets.chomp
      case choice2.to_i
      when 1
        delete_file_from_bin
      else
        @@command_line.aborting_program(true)
        exit
      end
    end
  end

  def print_bin_contents
    puts 'The contents in recycle bin:'
    puts '_________________________'
    puts Dir.each_child(RECYCLE_BIN_PATH) { |file| puts file }
    puts '_________________________'
  end
end
