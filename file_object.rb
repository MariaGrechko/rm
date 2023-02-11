require 'json'

class FileObject
  attr_accessor :file_name, :deletion_date, :initial_path

  def initialize(file_name, deletion_date, initial_path)
    @file_name = file_name
    @deletion_date = deletion_date
    @initial_path = initial_path
  end

  def to_json
    {
      file_name: @file_name,
      deletion_date: @deletion_date,
      initial_path: @initial_path
    }.to_json
  end

  def self.from_json(data)
    FileObject.new(data['file_name'], data['deletion_date'], data['initial_path'])
  end

  def deserialize_log
    file = File.read('.files_tracker.json')
    removed_files_in_json = JSON.parse(file)
    removed_files = FileObject.from_json(*removed_files_in_json)
    p removed_files
  end
end

# t1 = FileObject.new.deserialize_log
