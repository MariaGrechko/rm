require_relative './printer.rb'
require_relative './file_object.rb'
require_relative './removed_files_tracker.rb'
require 'fileutils'

class RecycleBin
  RECYCLE_BIN_PATH = File.expand_path('~/.recycle_bin')

  class << self
    def setup
      if !Dir.exist?(RECYCLE_BIN_PATH)
        Dir.mkdir(RECYCLE_BIN_PATH)
        $printer.call('The recycle bin has just been created.')
        recycle_bin = RecycleBin.new
      end
    end

    def print_bin_contents
      puts 'The contents in recycle bin:'
      puts '_________________________'
      puts Dir.each_child(RECYCLE_BIN_PATH) { |file| puts file }
      puts '_________________________'
    end

    def file_to_bin(file_names)
      file_names.each do |file_name|
        if File.exist?(file_name)
          file = FileObject.new(file_name, Time.now, File.expand_path('.'))
          FileUtils.mv(file.file_name, RECYCLE_BIN_PATH)
          RemovedFilesTracker.add_to_files_tracker(file)
          $printer.call("#{file_name} has been moved to the recycle bin.")
        else
          $printer.call("No file '#{file_name}' was found in #{Dir.pwd}")
        end
      end
    end

    def delete_all_from_bin
      if Dir.empty?(RECYCLE_BIN_PATH)
        $printer.call('The recycle bin is already empty.')
        exit
      end
      Dir.each_child(RECYCLE_BIN_PATH) do |file_name|
        file_to_delete = File.join(RECYCLE_BIN_PATH, file_name)
        File.delete(file_to_delete) if File.exist?(file_to_delete)
      end
      $printer.call('The bin is now empty.')
    end

    def restore_from_bin(files_to_restore)
      objects = RemovedFilesTracker.get_file_objects_from_files_tracker
      Dir.chdir(RECYCLE_BIN_PATH)
      file_restored = false
      files_to_restore.each do |file_to_restore|
        objects.each do |object|
          next if object.file_name != file_to_restore
          FileUtils.mv(object.file_name, object.initial_path)
          RemovedFilesTracker.delete_from_files_tracker(object)
          file_restored = true
          $printer.call("#{object.file_name} was successfully restored to #{object.initial_path}")
        end
        if !file_restored
          $printer.call("#{file_to_restore} doesn't exist in bin.")
        end
      end
    end

    def restore_all_from_bin
      Dir.chdir(RECYCLE_BIN_PATH)
      if Dir.empty?(RECYCLE_BIN_PATH)
        $printer.call('The recycle bin is already empty.')
        exit
      end
      objects = RemovedFilesTracker.get_file_objects_from_files_tracker
      objects.each do |object|
        FileUtils.mv(object.file_name, object.initial_path)
        RemovedFilesTracker.delete_from_files_tracker(object)
        file_restored = true
        $printer.call("#{object.file_name} was successfully restored to #{object.initial_path}")
        if !file_restored
          $printer.call("Something went wrong with #{object.file_name}.")
        end
      end
    end

    def delete_file_from_bin(files_to_delete)
      if Dir.children(RECYCLE_BIN_PATH).empty?
        $printer.call('The recycle bin is empty.')
        exit
      end
      files_to_delete.each do |file_to_delete_name|
        Dir.each_child(RECYCLE_BIN_PATH) do |file_name|
          found_to_delete = false
          next if file_name != file_to_delete_name
          file_to_delete = File.join(RECYCLE_BIN_PATH, file_to_delete_name)
          File.delete(file_to_delete) if File.exist?(file_to_delete)
          RemovedFilesTracker.delete_from_files_tracker(file_to_delete)
          found_to_delete = true
          $printer.call("The file #{file_to_delete_name} has been deleted from the recycle bin.")
          if !found_to_delete
            puts "Such file doesn't exist in #{RECYCLE_BIN_PATH}."
            exit
          end
        end
      end
    end
  end
end
