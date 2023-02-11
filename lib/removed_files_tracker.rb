require_relative './file_object.rb'

class RemovedFilesTracker
  FILES_TRACKER = File.expand_path('~/.files_tracker.json')

  def setup
    if !File.exist?(FILES_TRACKER)
      initial_data = [].to_json
      File.write(FILES_TRACKER, initial_data, mode: 'w')
      puts 'The files tracker file has just been created!'
    else
      puts 'The files tracker file already exists.'
    end
  end

  def add_to_files_tracker(deleted_file)
    already_removed_files = get_file_objects_from_files_tracker
    files_to_track = already_removed_files << deleted_file
    prepared_data_to_track = files_to_track.map(&:to_json)
    File.write(FILES_TRACKER, prepared_data_to_track.to_json, mode: 'w')
  end

  def get_file_objects_from_files_tracker
    files_tracker_file = File.read(FILES_TRACKER)
    files_tracker_data = JSON.parse(files_tracker_file)
    files_tracker_data.map do |removed_file_data|
      FileObject.from_json(removed_file_data)
    end
  end
end
