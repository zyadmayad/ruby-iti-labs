require_relative "../handler"

class ConsoleHandler < Handler
  def handle(event)
    timestamp = event.timestamp.strftime("%Y-%m-%d %H:%M")
    puts "[#{timestamp}] #{event.type_label} — #{event.description} (#{event.duration_minutes} min)"
  end
end
