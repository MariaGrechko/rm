require_relative './file_object.rb'

class RemovedFilesTracker
FILES_TRACKER = '.files_tracker.json'

  def create_files_tracker
    if !File.exist?(FILES_TRACKER)
      files_tracker.json = File.new(FILES_TRACKER, 'a')
      puts 'The files tracker file has just been created!'
    else
      puts 'The files tracker file already exists.'
    end
  end

  def add_to_files_tracker(*arr)
    file = File.open(FILES_TRACKER, 'r')
    arr.each do |object|
      File.write(FILES_TRACKER, object, mode: 'w')
    end
    file.close
  end
end
