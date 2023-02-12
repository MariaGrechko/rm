require_relative './file_object.rb'
require_relative './printer.rb'
require 'pry'

class RemovedFilesTracker
  FILES_TRACKER = File.expand_path('~/.files_tracker.json')
  @@printer = Printer.new

  class << self
    def setup
      if !File.exist?(FILES_TRACKER)
        initial_data = [].to_json
        File.write(FILES_TRACKER, initial_data, mode: 'w')
        @@printer.call('The files tracker file has just been created!')
      else
        @@printer.call('The files tracker file already exists.')
      end
    end

    def add_to_files_tracker(deleted_file)
      already_removed_files = get_file_objects_from_files_tracker
      files_to_track = already_removed_files << deleted_file
      prepared_data_to_track = files_to_track.map(&:to_json)
      File.write(FILES_TRACKER, prepared_data_to_track.to_json, mode: 'w')
    end

    def delete_from_files_tracker(restored_file)
      removed_files = get_file_objects_from_files_tracker
      removed_files.reject! { |deleted_file| deleted_file.file_name == restored_file.file_name && deleted_file.initial_path == restored_file.initial_path && deleted_file.deletion_date == restored_file.deletion_date }
      updated_data_to_track = removed_files.map(&:to_json)
      File.write(FILES_TRACKER, updated_data_to_track.to_json, mode: 'w')
    end

    def get_file_objects_from_files_tracker
      files_tracker_file = File.read(FILES_TRACKER)
      files_tracker_data = JSON.parse(files_tracker_file)
      files_tracker_data.map do |removed_file_data|
        FileObject.from_json(removed_file_data)
      end
    end
  end
end
