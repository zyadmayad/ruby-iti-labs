require "fileutils"
require_relative "../handler"

class FileHandler < Handler
  def initialize(log_path)
    @log_path = log_path
    FileUtils.mkdir_p(File.dirname(@log_path))
  end

  def handle(event)
    timestamp = event.timestamp.strftime("%Y-%m-%d %H:%M")
    line = "[#{timestamp}] #{event.type_label} — #{event.description} (#{event.duration_minutes} min)\n"
    File.open(@log_path, "a") { |file| file.write(line) }
  end
end
