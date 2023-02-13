class Printer
  def call(text)
    return if @silent_mode

    puts text
  end

  def initialize(silent_mode = false)
    @silent_mode = silent_mode
  end
end
