require_relative './initializator.rb'
require_relative './removed_files_tracker.rb'
require_relative './recycle_bin.rb'

class Commander
  def self.call
    case ARGV[0]
      when 'setup'
        Initializator.call
      when 'file_to_bin'
        RecycleBin.file_to_bin(ARGV[1..])
      when '--restore'
        RecycleBin.restore_from_bin(ARGV[1..])
      when '--clean'
        RecycleBin.delete_all_from_bin
      when '--show'
        RecycleBin.print_bin_contents
      else puts 'Invalid command'
    end
  end
end
