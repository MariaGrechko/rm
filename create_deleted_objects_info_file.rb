require_relative './file_object.rb'

class Create_Deleted_Objects_Info_File
  attr_accessor :file_name, :deletion_date, :initial_path

  def create_deleted_objects_info_file
    if !File.exist?(deleted_objects_info.json)
      deleted_objects_info.json = File.new('deleted_objects_info.json', 'a')
      puts 'The DeletedObjectsInfo file has just been created!'
    else
      puts 'The DeletedObjectsInfo file already exists.'
    end
  end

  def add_to_deleted_objects_info(*arr)
    file = File.open('deleted_objects_info.json', 'r')
    arr.each do |object|
      File.write('deleted_objects_info.json', object, mode: 'w')
    end
    file.close
  end
end