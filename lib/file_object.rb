require 'json'

class FileObject
  attr_accessor :file_name, :deletion_date, :initial_path

  def initialize(file_name, deletion_date, initial_path)
    @file_name = file_name
    @deletion_date = deletion_date
    @initial_path = initial_path
  end

  # def restore_name
  #   @file_name
  # end

  # def to_restore_path
  #   @initial_path
  # end

  def to_json
    {
      file_name: @file_name,
      deletion_date: @deletion_date,
      initial_path: @initial_path
    }
  end

  def self.from_json(data)
    FileObject.new(data['file_name'], data['deletion_date'], data['initial_path'])
  end
end
