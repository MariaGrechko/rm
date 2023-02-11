require_relative './removed_files_tracker.rb'
require_relative './recycle_bin.rb'

class Initializator
  class << self
    def call
      initialize_recycle_bin
      initialize_remove_files_tracker
      setup_command_line
    end

    private

    def initialize_recycle_bin
      RecycleBin.setup
    end

    def initialize_remove_files_tracker
      RemovedFilesTracker.setup
    end

    def setup_command_line
      # TODO: later
    end
  end
end
