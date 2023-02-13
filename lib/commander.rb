require_relative './initializator.rb'
require_relative './removed_files_tracker.rb'
require_relative './recycle_bin.rb'
require_relative './printer.rb'
require 'optparse'

class Commander
  def self.call
    $printer = Printer.new
    ARGV.include?('--silent') ? $printer = Printer.new(true) : $printer = Printer.new
    ARGV.reject! { |argv| argv == '--silent' }
    OptionParser.new do |parser|
      parser.on('-i', '--init', 'Initializes recycle bin and files tracker.') do
        Initializator.call
      end
      parser.on('-l', '--list', 'Prints recycle bin contents.') do
        RecycleBin.print_bin_contents
      end
      parser.on('-d', 'Deletes user input files from current directory.') do
        RecycleBin.file_to_bin(ARGV)
      end
      parser.on('-c', '--clean', 'Permanently deletes all data from the recycle bin.') do
        RecycleBin.delete_all_from_bin
      end
      parser.on('-r', 'Restores user input files from the recycle bin.') do
        RecycleBin.restore_from_bin(ARGV)
      end
      parser.on('-r_a', '--restore_all', 'Restores all data from the recycle bin.') do
        RecycleBin.restore_all_from_bin
      end
      parser.on('-h', '--help') do
        puts parser
      end
    end.parse!
  end
end

