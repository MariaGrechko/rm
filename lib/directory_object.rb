# require 'json'

# class DirectoryObject
#   attr_reader :dir_name, :deletion_date, :initial_path

#   def initialize(dir_name, deletion_date, initial_path)
#     @dir_name = dir_name
#     @deletion_date = deletion_date
#     @initial_path = initial_path
#   end

#   def create_Deleted_Objects_Info_dir
#     if !File.exist?(deleted_objects_info.json)
#       deleted_objects_info.json = File.new('deleted_objects_info.json', 'a')
#       puts 'The DeletedObjectsInfo file has just been created!'
#     else
#       puts 'The DeletedObjectsInfo file already exists.'
#     end
#   end

#   def add_to_deleted_objects_info(data)
#     file = File.open('deleted_objects_info.json', 'a')
#     file.write('deleted_objects_info.json', data + "\n", mode: 'a')
#     file.close
#   end #array

#   def to_json 
#     {
#       dir_name: @dir_name,
#       deletion_date: @deletion_date,
#       initial_path: @initial_path
#     }.to_json
#   end

#   def self.from_json(data)
#     DirectoryObject.new(data['dir_name'], data['deletion_date'], data['initial_path'])
#   end

#   def deserialize_log
#     file = File.read('deleted_objects_info.json')
#     removed_files_in_json = JSON.parse(file)
#     removed_files = DirectoryObject.from_json(removed_files_in_json)
#     p removed_files
#   end

# end

# # Dir.mkdir('Testdir')
# test = DirectoryObject.new('Testdir', '07.02.2023', '/Users/manichkagrechechka/Desktop/Ruby/rm_utility')
# p test
# p test.to_json
# test.add_to_deleted_objects_info(test.to_json)
# test.deserialize_log